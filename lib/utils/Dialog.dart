import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hadaf/utils/colors.dart';

// ignore: non_constant_identifier_names
ShowDialog({@required BuildContext context ,  Widget child , double opacity = 0.5 ,double height , EdgeInsets margin  ,BorderRadius radius , Alignment alignment}){
  showGeneralDialog(
    barrierLabel: "Label",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(opacity),
    transitionDuration: Duration(milliseconds: 100),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return child ;
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0)
            .animate(anim1),
        child:  Align(
          alignment: alignment ?? Alignment.center,
          child: Container(
            height: height ,
            child: SizedBox.expand(
                child: Material(
                  borderRadius: radius ?? BorderRadius.circular(0),
                  child: ClipRRect(
                      borderRadius: radius ?? BorderRadius.circular(0),
                      child: child),
                )),
            margin: margin ?? EdgeInsets.only(
                bottom: 16, left: 12, right: 12),
          ),
        ),
      );
    },
  );
}
Future<void> showOptionDialog(BuildContext context , {Function onApprove , String title , String desc }) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title??'delete'.tr()),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(desc??'delete_company'.tr()),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('yes'.tr() , style: TextStyle(color: PRIMARY_COLOR),),
            onPressed: onApprove??(){},
          ),
          FlatButton(
            child: Text('cancel'.tr() , style: TextStyle(color: PRIMARY_COLOR),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
