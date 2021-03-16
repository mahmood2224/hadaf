import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hadaf/data/api_provider.dart';
import 'package:hadaf/data/models/auth_send_model.dart';
import 'package:hadaf/data/userData.dart';
import 'package:hadaf/ui/views/home.dart';
import 'package:hadaf/ui/views/register.dart';
import 'package:hadaf/ui/widgets/delivery_button.dart';
import 'package:hadaf/ui/widgets/delivery_text_field.dart';
import 'package:hadaf/ui/widgets/logo.dart';
import 'package:hadaf/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _userName = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  bool _loading = false ;

  String errorMsg = "" ;

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
  }
  _initFireBase()async{
    int userId = await getUserId() ;
    if (Platform.isIOS) iOS_Permission();
    _firebaseMessaging.getToken().then((value) =>
        ApiProvider.saveFcmToken(firebaseToken: value , onSuccess: (){} , onError: (error){})
    );
    _firebaseMessaging.subscribeToTopic("users_$userId");
    _firebaseMessaging.subscribeToTopic("users");
  }

  void iOS_Permission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  _login(){
    setState((){
      _loading=true;
      errorMsg ="" ;
    });
    ApiProvider.login(body: AuthSendModel(userName: _userName.text , password: _password.text) ,onError: (error)=>
      setState(() {
        _loading = false ;
        errorMsg = error ;
      }),
      onSuccess: (){
      setState(() =>_loading = false );
      _initFireBase();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: width,
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60,),
              Center(child: Logo(width: 120, height: 130, isAuth: true,)),
              SizedBox(height: 32,),
              Text(
                "login_text".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22,

                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16,),
              DeliveryTextField(
                label: "user_name".tr(),
                hint: "ex_user_name".tr(),
                controller: _userName,
                width: width / 1.1,
                height: 50,
              ),
              SizedBox(
                height: 16,
              ),
              DeliveryTextField(
                label: "password".tr(),
                hint: "ex_password".tr(),
                obscure: true,
                controller: _password,
                width: width / 1.1,
                height: 50,
              ),

              Text("$errorMsg" , style: TextStyle(color: Colors.red , fontSize: 14 , fontWeight: FontWeight.bold) ,),
              SizedBox(
                height: 20,
              ),
              Center(
                child: DeliveryButton(
                  width : width-64,
                  height: 50,
                  textColor: Colors.white,
                  text: "login".tr(),
                  onPressed:_login,
                  loading: _loading,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: DeliveryButton(
                  width: width-64,
                  height: 50,
                  textColor: PRIMARY_COLOR,
                  border: Border.all(color: PRIMARY_COLOR , width: 1),
                  background: Colors.white,
                  text: "sign_up_now".tr(),
                  onPressed:()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Register())),
                ),
              ),
            ],
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
