import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  double width ;
  double height ;
  bool isAuth ;


  Logo({this.width, this.height , this.isAuth = false });

  @override
  Widget build(BuildContext context) {
    return Image.asset(this.isAuth ? "assets/images/logo_auth.png": "assets/images/logo.png" , width: width , height: height,);
  }
}
