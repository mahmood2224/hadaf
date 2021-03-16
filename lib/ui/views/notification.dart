import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadaf/data/api_provider.dart';
import 'package:hadaf/data/models/home_codes.dart';
import 'package:hadaf/data/models/notification_models.dart';
import 'package:hadaf/data/userData.dart';
import 'package:hadaf/ui/views/add_pincode.dart';
import 'package:hadaf/ui/views/product.dart';
import 'package:hadaf/ui/widgets/Loading.dart';
import 'package:hadaf/ui/widgets/logo.dart';
import 'package:hadaf/utils/Dialog.dart';
import 'package:hadaf/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() {
    return _NotificationPageState();
  }
}

class _NotificationPageState extends State<NotificationPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<SingleNotification> notifications = [];

  bool _loading = false;
  @override
  void initState() {
    super.initState();
    _getNotifications();
  }

  _getNotifications() {
    setState(() => _loading = true);
    ApiProvider.getNotifications(
        onError: (error) => setState(() => _loading = false),
        onSuccess: (notifications) => setState(() {
              this.notifications = notifications;
              this._loading = false;
            }));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            child: Container(
              height: 300,
              color: PRIMARY_COLOR,
              child: Column(
                children: [
                  Container(
                    height: 80,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        title: Text(
                          "notifications".tr(),
                        ),
                        centerTitle: true,
                      ),
                    ),
                  ),
//                  Container()  // for making anther designs in header
                ],
              ),
            ),
          ),
          PositionedDirectional(
            top: 90,
            start: 0,
            end: 0,
            bottom: 0,
            child: Container(
              height: height - 90,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Color(0xffF4F6FA),
                  borderRadius: BorderRadius.circular(16)),
//              child: SingleChildScrollView(
//                child: Container(
//
//                ),
//              ),
              child: _loading ?Loading() :Container(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  itemCount: this.notifications?.length??0,
                  itemBuilder: (context, index) {
                    SingleNotification notification = notifications[index] ;
                    return Container(
                      width: width,
                      constraints: BoxConstraints(minHeight: 30),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      margin: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/notify_icon.svg",
                            width: 20,
                            height: 20,
                            color: PRIMARY_COLOR,
                          ),
                          SizedBox(width: 16,),
                          Container(
                            width: width - 40 -82- 20 - 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${notification?.title??""}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "${notification?.desc??""}",
                                  style: TextStyle(
                                      fontSize: 12,),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
