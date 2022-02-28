import 'package:flutter_svg/flutter_svg.dart';
import '/data/models/counts_model.dart';
import '/data/models/status_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/data/api_provider.dart';
import '/data/models/home_codes.dart';
import '/data/node_api_provider.dart';
import '/ui/views/filter_page.dart';
import '/ui/views/pending.dart';
import '/ui/views/search_result.dart';
import '/ui/widgets/Loading.dart';
import '/ui/widgets/app_bar.dart';
import '/ui/widgets/logo.dart';
import '/utils/Config.dart';
import '/utils/algorithms.dart';
import '/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CodeModel {
  int code;
  String name;
  int count;
  Color codeColor;
  String icon;

  CodeModel({this.code, this.name, this.count, this.codeColor, this.icon});
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

  List<Count> counts = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  DomainModel status;

  @override
  void initState() {
    super.initState();
    _getSingleCode();
    // _getStatus();
  }

  _getSingleCode({bool isRefresh = false}) {
    setState(() => _loading = true);
    NodeApiProvider.getCodeCounts(widget.code?.type,
        accountId: widget.code?.account_code,
        onError: (error) => setState(() => _loading = false),
        onSuccess: (counts) => setState(() {
              _loading = false;
              this.counts = counts;
              // _getStatus();
            }));
    if (isRefresh) _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: HadafAppBar(context,
          title:
              "${widget.code?.account_name ?? ""} - ${widget.code?.pin_code ?? ""}",
          actions: [
            IconButton(
                icon: Icon(
                  FontAwesomeIcons.filter,
                  size: 20,
                ),
                onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              FilterPage((FilterResult result) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SearchResult(
                                          widget.code?.type,
                                          accountId: widget.code.account_code ,
                                          filter: result ,
                                        )));
                              })))
                    })
          ]),
      body: Container(
        height: height,
        decoration: BoxDecoration(
            color: Color(0xffF4F6FA), borderRadius: BorderRadius.circular(16)),
        child: _loading
            ? Loading()
            : Container(
                child: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: () => _getSingleCode(isRefresh: true),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // SizedBox(height: 8,),
                        // Container(
                        //   color: Colors.white,
                        //   padding: EdgeInsets.symmetric(horizontal: 33 ,vertical: 16),
                        //   child:Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Container(
                        //         padding : EdgeInsets.symmetric(horizontal: 40),
                        //         child: Row(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Image.asset("assets/images/num_orders.png" ,height: 24, width: 24,),
                        //             SizedBox(width: 4,),
                        //             Column(
                        //               mainAxisAlignment: MainAxisAlignment.start,
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Text("orders".tr() , style: TextStyle(fontSize: 12), textAlign: TextAlign.start,),
                        //                 Text('${code?.countAll ?? 0}'+" "+"order".tr() , style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold),),
                        //
                        //               ],
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //       (this.status?.balance??0) == 0 ? Container():Container(height: 50, width: 1, color: Colors.grey,),
                        //       (this.status?.balance??0) == 0?Container(): Container(
                        //         padding : EdgeInsets.symmetric(horizontal: 40),
                        //         child: Row(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           children: [
                        //             Image.asset("assets/images/balance.png" ,height: 24, width: 24,),
                        //             SizedBox(width: 4,),
                        //             Column(
                        //               mainAxisAlignment: MainAxisAlignment.start,
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Text("wallet".tr() , style: TextStyle(fontSize: 12), textAlign: TextAlign.start,),
                        //                 Text('${code?.balance ?? 0}  '+"cr".tr() , style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold),),
                        //
                        //               ],
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 8,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          itemCount: this.counts?.length ?? 0,
                          itemBuilder: (context, index) {
                            Count count = counts[index];
                            bool notShowData =
                                    count.status == CodesTypes.DRIVER_PAID;
                            return InkWell(
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => Pending(
                                            widget.code?.type,
                                            accountId:
                                                widget.code?.account_code,
                                            status: count?.status,
                                            name: widget.code?.account_name,
                                            cont: count,
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                count?.icon,
                                                width: 32,
                                                height: 32,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${count?.status_name ?? ""}",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: count?.color ??
                                                          Colors.black,
                                                    ),
                                                  ),
                                                  notShowData
                                                      ? Container()
                                                      : Text(
                                                          '${count?.count ?? 0}  ' +
                                                              "order".tr(),
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Color(
                                                                0xff000000),
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
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10),
                                      height: 1,
                                      width: width,
                                      color: Color(0x26000000),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        notShowData
                                            ? Container()
                                            : Container(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "wallet".tr() + " : ",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0x33232446),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          right: 16),
                                                      child: Text(
                                                        convertNumbersString(
                                                            count?.total_price ??
                                                                "0"),
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black45,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                        Container(
                                          child: Container(
                                            padding: EdgeInsets.only(right: 6),
                                            child: Container(
                                              width: 50,
                                              height: 32,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: count?.color),
                                              child: Center(
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
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
                        SizedBox(
                          height: 16,
                        )
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
