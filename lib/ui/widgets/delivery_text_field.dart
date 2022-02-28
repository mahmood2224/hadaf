import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class DeliveryTextField extends StatelessWidget {
  TextEditingController controller ;
  String hint ;
  double width ;
  double height ;
  bool obscure ;
  String label ;
  int liens ;
  Color labelColor ;
  Color backGroundColor ;
  TextInputType textType ;

  DeliveryTextField({this.controller, this.hint="", this.liens = 1 ,this.width=200, this.height,
      this.obscure=false , this.label = "label" ,this.labelColor , this.backGroundColor , this.textType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(this.label , style: TextStyle(fontSize: 13 , fontWeight: FontWeight.w500 ,color:this.labelColor ?? Colors.black),),
          SizedBox(height: 6,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: this.backGroundColor??Color(0x22000000)
            ),
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller:controller ?? new TextEditingController(),
              textAlign: TextAlign.start,
              obscureText: obscure,
              minLines: liens,
               maxLines: liens,
              keyboardType: this.textType ?? TextInputType.text,
              style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold,color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(color: Colors.grey)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
