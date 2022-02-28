import 'package:flutter/material.dart';
import '/ui/widgets/Loading.dart';
import '/utils/colors.dart';

class DeliveryButton extends StatelessWidget {
  String text ;
  Function onPressed ;
  double width ;
  double height ;
  BoxDecoration decoration;
  Color textColor ;
  bool loading ;
  Color background ;
  Border border ;

  DeliveryButton({this.text, this.background , this.border,this.onPressed, this.width, this.height ,this.decoration ,this.textColor,this.loading =false });

  @override
  Widget build(BuildContext context) {
    return this.loading ? Loading():InkWell(
      onTap: onPressed,
      child: Container(
        width: width ?? 200,
        height: height ?? 42,
        decoration: decoration ?? BoxDecoration(
          color: this.background ?? ACCENT_COLOR,
          borderRadius: BorderRadius.circular(10),
          border:  this.border
        ),
        child: Center(
          child: Text(text??"" , style: TextStyle(color: textColor??Colors.white , fontSize: 16 , fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
