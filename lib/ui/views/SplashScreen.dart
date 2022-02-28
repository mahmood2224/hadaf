import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '/data/api_provider.dart';
import '/data/userData.dart';
import '/ui/views/home.dart';
import '/ui/views/login.dart';
import '/ui/widgets/logo.dart';
import '/utils/colors.dart';
import '/data/data_constatnts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    getDomain();
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
  Timer _timer;

  void getDomain(){
    // bindDomain("http://192.168.43.15:8080");
    _timer = new Timer(
        Duration(seconds: 1),
            ()async {
          this.iOS_Permission();
          String token = await getToken();
          if(token == null ){
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
          }else{
            _initFireBase();
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
          }
        });

    ApiProvider.getDomain(onError: (){} , onSuccess: (domain){
      bindDomain(domain.domain);
      _timer = new Timer(
          Duration(seconds: 1),
              ()async {
            this.iOS_Permission();
            String token = await getToken();
            if(token == null ){
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
            }else{
              _initFireBase();
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
            }
          });
    });
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/splash_screen.png") , fit: BoxFit.fill)
        ),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.stretch,
        //   children: [
        //     Flexible( flex:  2 ,child: Container(child: Center(child: Logo()))),
        //     Flexible( flex:  1 ,child: Container()),
        //   ],
        // ),
      )
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
