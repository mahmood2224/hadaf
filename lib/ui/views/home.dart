import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/data/api_provider.dart';
import '/data/models/home_codes.dart';
import '/data/userData.dart';
import '/ui/views/add_pincode.dart';
import '/ui/views/notification.dart';
import '/ui/views/product.dart';
import '/ui/widgets/Loading.dart';
import '/ui/widgets/app_bar.dart';
import '/ui/widgets/logo.dart';
import '/utils/Dialog.dart';
import '/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Code> codes = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance ;

  bool _loading = false;
  @override
  void initState() {
    super.initState();
    _getCodes();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotificationDialog(context, title: message?.notification?.title, desc: message?.notification?.body);
    });
  }

  _getCodes({bool isRefresh = false}) {
    setState(() => _loading = true);
    ApiProvider.home(
        onError: (error) => setState(() => _loading = false),
        onSuccess: (codes) => setState(() {
              this.codes = codes;
              this._loading = false;
            }));
    if (isRefresh) _refreshController.refreshCompleted();
  }

  _removeCode(String codeId) {
    setState(() => _loading = true);
    ApiProvider.removeCode(
        codeId: codeId,
        onSuccess: _getCodes,
        onError: (error) => setState(() => _loading = false));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: HadafAppBar(context ,
        titleWidget: Logo(
          width: 33,
          height: 32,
        ),
        leading: InkWell(
            onTap: () => showOptionDialog(context,
                title: "تسجيل الخروج",
                desc: "هل انت متاكد من تسجيل الخروج؟",
                onApprove: () => logout(context)),
            child: Icon(FontAwesomeIcons.signOutAlt, color: Colors.black,) ),
        actions: [
          InkWell(
              onTap: () => ShowDialog(
                  context: context,
                  height: 350,
                  radius: BorderRadius.circular(16),
                  child: AddPinCode(
                    onSuccess: _getCodes,
                  ),
                  alignment: Alignment.center),
              child: SvgPicture.asset(
                "assets/icons/add.svg",
                color: Colors.black,
              )),
          SizedBox(
            width: 16,
          ),
          InkWell(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NotificationPage())),
              child: SvgPicture.asset(
                "assets/icons/notify_icon.svg",
                width: 25,
                height: 25,
                color: Colors.black,
              )),
          SizedBox(
            width: 16,
          ),
        ],
      ),
      key: _scaffoldKey,
      body: Container(
        height: height ,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Color(0xffF4F6FA),
            borderRadius: BorderRadius.circular(16)),
//              child: SingleChildScrollView(
//                child: Container(
//
//                ),
//              ),
        child: _loading
            ? Loading()
            : this.codes.isEmpty
                ? Center(
                    child: Text(
                      "no_data".tr(),
                      style:
                          TextStyle(color: PRIMARY_COLOR, fontSize: 14),
                    ),
                  )
                : Container(
                    child: SmartRefresher(
                      onRefresh: () => _getCodes(isRefresh: true),
                      controller: _refreshController,
                      child: ListView.builder(
                        itemCount: this.codes?.length ?? 0,
                        itemBuilder: (context, index) {
                          Code code = this.codes[index];
                          return InkWell(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Product(code))),
                            child: Container(
                              width: width,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
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
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 13),
                                              child: Icon(FontAwesomeIcons.building , size: 22,),
                                            ),
                                            Text(
                                              '${code?.account_name ?? ""}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight:
                                                    FontWeight.bold,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Text(
                                              '${code?.pin_code ?? ""}',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight:
                                                    FontWeight.bold,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: 13),
                                              child: Text(
                                                '#',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight:
                                                      FontWeight.w500,
                                                  color:
                                                      Color(0x33000000),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 5),
                                    child: Image.asset(
                                      'assets/images/betweenHr.png',
                                      width: width,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () => showOptionDialog(
                                            context, onApprove: () {
                                          Navigator.pop(context);
                                          _removeCode("${code?.id}");
                                        }),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.trash,
                                                size: 15,
                                                color: Colors.red,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(
                                                    right: 4),
                                                child: Text(
                                                  'delete'.tr(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(
                                            right: 6),
                                        child:Container(
                                          width: 50,
                                          height: 32,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              color: PRIMARY_COLOR
                                          ),
                                          child: Center(
                                            child: Icon(Icons.arrow_forward , color: Colors.white, size: 20,),
                                          ),
                                        )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
