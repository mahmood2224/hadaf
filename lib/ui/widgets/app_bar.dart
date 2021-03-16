import 'dart:ui';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadaf/ui/widgets/Logo.dart';
import 'package:hadaf/utils/colors.dart';

PreferredSize HadafAppBar(BuildContext context,
    {String title = "",Widget titleWidget, GlobalKey<ScaffoldState> scaffoldKey , List<Widget> actions , Widget leading}) {
  return PreferredSize(
    child: Container(
      child: AppBar(
          title:titleWidget ?? (title.isNotEmpty
              ? Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )
              : Logo()),
          actions: actions??[],
          leading:leading ?? InkWell(
            onTap: ()=>Navigator.pop(context),
              child:Icon(Icons.arrow_back_ios )),
          backgroundColor: Colors.white,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
            size: 18, //change your color here
          )),
    ),
    preferredSize: Size.fromHeight(60),
  );
}
