import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/utils/colors.dart';

class DropDownModel{
  String name ;
  dynamic object ;

  DropDownModel({this.name, this.object});

}

class DeliveryDropdown extends StatefulWidget {
  String label;

  Color textColor;

  String error ;
  
  double height;

  double width;


  List<DropDownModel> items;

  Function onSelectItem;
  
  Color backgroundColor ;

  BoxDecoration decoration ;


  DeliveryDropdown({
    this.label="",
    this.textColor,
    this.height = 40,
    this.width,
    this.items  ,
    this.onSelectItem,
    this.error="",
    this.backgroundColor,
    this.decoration
  });

  @override
  _ClickDropdownState createState() {
    return _ClickDropdownState();
  }
}

class _ClickDropdownState extends State<DeliveryDropdown> {
  dynamic value ;
  @override
  void initState() {
    super.initState();
    value = widget.items != null ? widget.items[0].object : null ;
  }

  @override
  void dispose() {
    super.dispose();
  }
   get fontColor => widget.backgroundColor != Colors.white ? Colors.grey : Colors.black ;
  @override
  Widget build(BuildContext context) {
     return Container(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: <Widget>[
          widget.label.isEmpty ? Container(): Align(
               alignment: AlignmentDirectional.centerStart,
               child: Text(widget.label ?? "")),
           widget.label.isEmpty ? Container(): SizedBox(
             height: 8,
           ),
           Container(
             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
             decoration:widget.decoration ??  BoxDecoration(
                 color: widget.backgroundColor ?? GREY_COLOR,
                 borderRadius: BorderRadius.circular(10)
             ),
             height:  widget.height,
             width:widget.width,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 DropdownButton(
                   underline: Container(),
                   value:this.value ,
                   icon: Icon(Icons.arrow_drop_down , size: 20, color:widget.textColor ?? fontColor,),
                   items: widget.items.map((DropDownModel value) {
                     return new DropdownMenuItem(
                       value: value.object,
                       child:  Container(
                           width:   widget.width-68.0 ,
                           child: Align( alignment: AlignmentDirectional.centerStart,child: Text(value?.name??"لا يوجد اسم" ,style:  TextStyle(color: widget.textColor ?? fontColor ),))),
                     );
                   }).toList(),
                   onChanged: (value) {
                     setState(() => this.value = value);
                     widget.onSelectItem(value);
                   },
                 ),
               ],
             ),
           ),
          widget.error.isEmpty ?Container(): SizedBox(
             height: 8,
           ),
           widget.error.isEmpty ?Container(): Align(
               alignment: AlignmentDirectional.centerStart,
               child: Text(widget.error??""  ,style: TextStyle(fontSize: 10 ,color: Colors.red),)),

         ],
       ),
     );;
  }
}
