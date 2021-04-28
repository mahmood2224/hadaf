import 'package:flutter_svg/flutter_svg.dart';
import 'package:hadaf/data/models/status_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadaf/data/api_provider.dart';
import 'package:hadaf/data/models/home_codes.dart';
import 'package:hadaf/ui/views/filter_page.dart';
import 'package:hadaf/ui/views/pending.dart';
import 'package:hadaf/ui/widgets/Loading.dart';
import 'package:hadaf/ui/widgets/app_bar.dart';
import 'package:hadaf/ui/widgets/logo.dart';
import 'package:hadaf/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CodeModel {
  int code;
  String name;
  int count;
  Color codeColor;
  String icon ;

  CodeModel({this.code, this.name, this.count, this.codeColor , this.icon});
}

class Product extends StatefulWidget {
  Code code;

  Product(this.code);

  @override
  _ProductState createState() {
    return _ProductState();
  }
}

class _ProductState extends State<Product> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _loading = false;

  CodeServer code = new CodeServer();

  List<CodeModel> counts = [];

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  Status status;


  @override
  void initState() {
    super.initState();
    _getSingleCode();
    _getStatus();
  }

  _getSingleCode({bool isRefresh = false}) {
    setState(() => _loading = true);
    ApiProvider.singleCode(
        pinCode: widget.code?.pin_code,
        onError: (error) => setState(() => _loading = false),
        onSuccess: (code) => setState(() {
          _loading = false;
          this.code = code;
          _getStatus();
        }));
    if (isRefresh) _refreshController.refreshCompleted();
  }

  _getStatus() {
    setState(() => _loading = true);
    ApiProvider.getStatus(
        onSuccess: (status) {
          setState(() {
            this.status = status;
            this._loading = false ;
          });
          _getList();
        },
        onError: () =>setState(()=>_loading = false ));
  }

  _getList() {
    counts.clear();
    setState(() {
      if (this.code?.countPending != null &&
          (this.status?.pending ?? 1) == 1)
        counts.add(CodeModel(
            code: CodesTypes.PENDING,
            count: this.code.countPending,
            name: CodesTypes.getTypeName(CodesTypes.PENDING),
            codeColor: CodesTypes.getTypeColor(CodesTypes.PENDING),
            icon: CodesTypes.getTypeIcon(CodesTypes.PENDING)
        ));
      if (this.code?.countInProcess != null &&
          (this.status?.on_progress ?? 1) == 1)
        counts.add(CodeModel(
            code: CodesTypes.IN_PROGRESS,
            count: this.code.countInProcess,
            name: CodesTypes.getTypeName(CodesTypes.IN_PROGRESS),
            codeColor: CodesTypes.getTypeColor(CodesTypes.IN_PROGRESS) ,
            icon: CodesTypes.getTypeIcon(CodesTypes.IN_PROGRESS)
        ));
      if (this.code?.countDeleverAll != null &&
          (this.status?.delivered ?? 1) == 1)
        counts.add(CodeModel(
            code: CodesTypes.DELIVERED,
            count: ((this.code?.countDeleverAll??0)),
            name: CodesTypes.getTypeName(CodesTypes.DELIVERED),
            codeColor: CodesTypes.getTypeColor(CodesTypes.DELIVERED),
            icon: CodesTypes.getTypeIcon(CodesTypes.DELIVERED)
        ));
      if (this.code?.countReturenAll != null &&
          (this.status?.returned ?? 1) == 1)
        counts.add(CodeModel(
            code: CodesTypes.RETURNED,
            count: this.code.countReturenAll,
            name: CodesTypes.getTypeName(CodesTypes.RETURNED),
            codeColor: CodesTypes.getTypeColor(CodesTypes.RETURNED),
            icon: CodesTypes.getTypeIcon(CodesTypes.RETURNED)
        ));
      if (this.code?.countReturenClient != null &&
          (this.status?.returned_client ?? 1) == 1)
        counts.add(CodeModel(
            code: CodesTypes.RETURNED_CLIENT,
            count: this.code.countReturenClient,
            name: CodesTypes.getTypeName(CodesTypes.RETURNED_CLIENT),
            codeColor: CodesTypes.getTypeColor(CodesTypes.RETURNED_CLIENT),
            icon: CodesTypes.getTypeIcon(CodesTypes.RETURNED_CLIENT)
        ));
      if (this.code?.countDeleverTasdeed != null &&
          (this.status?.delivered_paid ?? 1) == 1)
        counts.add(CodeModel(
            code: CodesTypes.DELIVERED_PAID,
            count: this.code.countDeleverTasdeed,
            name: CodesTypes.getTypeName(CodesTypes.DELIVERED_PAID),
            codeColor: CodesTypes.getTypeColor(CodesTypes.DELIVERED_PAID),
            icon: CodesTypes.getTypeIcon(CodesTypes.DELIVERED_PAID)
        ));
    });


  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: HadafAppBar(context , title: "${widget.code?.account_name ?? ""} - ${widget.code?.pin_code ?? ""}" , ),
      body: Container(
        height: height ,
        decoration: BoxDecoration(
            color: Color(0xffF4F6FA),
            borderRadius: BorderRadius.circular(16)),
        child: _loading
            ? Loading()
            : Container(
          child: SmartRefresher(
            controller: _refreshController,
            onRefresh: () => _getSingleCode(isRefresh: true),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 8,),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 33 ,vertical: 16),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding : EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset("assets/images/num_orders.png" ,height: 24, width: 24,),
                              SizedBox(width: 4,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("orders".tr() , style: TextStyle(fontSize: 12), textAlign: TextAlign.start,),
                                  Text('${code?.countAll ?? 0}'+" "+"order".tr() , style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold),),

                                ],
                              )
                            ],
                          ),
                        ),
                        (this.status?.balance??0) == 0 ? Container():Container(height: 50, width: 1, color: Colors.grey,),
                        (this.status?.balance??0) == 0?Container(): Container(
                          padding : EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset("assets/images/balance.png" ,height: 24, width: 24,),
                              SizedBox(width: 4,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("wallet".tr() , style: TextStyle(fontSize: 12), textAlign: TextAlign.start,),
                                  Text('${code?.balance ?? 0}  '+"cr".tr() , style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold),),

                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    itemCount: this.counts?.length ?? 0,
                    itemBuilder: (context, index) {
                      CodeModel count = counts[index];
                      return InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Pending(
                                  code: count,
                                  accountNum: this.code?.accountCode,
                                ))),
                        child: Container(
                          width: width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Image.asset(count?.icon , width: 32, height: 32,),
                                        SizedBox(width: 8,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${count?.name ?? ""}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: count?.codeColor ??
                                                    Colors.black,
                                              ),
                                            ),
                                            Text(
                                              '${count?.count ?? 0}  ' +"order".tr(),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                height: 1,
                                width: width,
                                color: Color(0x26000000),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
//                                  child: Row(
//                                    children: [
//
//                                      Text("last_update".tr(), style: TextStyle(
//                                        fontSize: 12,
//                                        fontWeight: FontWeight.bold,
//                                        color: Color(0x33232446),
//                                      ),
//                                      ),
//                                      Container(
//                                        padding: EdgeInsets.only(right: 16),
//                                        child: Text('01/21/2020 - 10:30 am', style: TextStyle(
//                                          fontSize: 12,
//                                          color: Color(0x4D232446),
//                                        ),
//                                        ),
//                                      )
//                                    ],
//                                  ),
                                  ),
                                  Container(
                                    child: Container(
                                      padding:
                                      EdgeInsets.only(right: 6),
                                      child: Container(
                                        width: 50,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: count?.codeColor
                                        ),
                                        child: Center(
                                          child: Icon(Icons.arrow_forward , color: Colors.white, size: 20,),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
