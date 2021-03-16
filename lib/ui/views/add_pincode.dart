import 'package:flutter/material.dart';
import 'package:hadaf/data/api_provider.dart';
import 'package:hadaf/ui/widgets/delivery_button.dart';
import 'package:hadaf/ui/widgets/delivery_text_field.dart';
import 'package:easy_localization/easy_localization.dart';

class AddPinCode extends StatefulWidget {

  Function onSuccess ;

  AddPinCode({this.onSuccess});

  @override
  _AddPinCodeState createState() {
    return _AddPinCodeState();
  }
}

class _AddPinCodeState extends State<AddPinCode> {

  bool _loading = false ;

  TextEditingController _code = new TextEditingController();

  String errorMsg ="" ;
  @override
  void initState() {
    super.initState();
  }
  _addCode(){
    setState((){
      _loading=true;
      errorMsg ="" ;
    });
    ApiProvider.addCode( code: _code.text ,onError: (error)=>
        setState(() {
          _loading = false ;
          errorMsg = error ;
        }),
        onSuccess: (){
          setState(() =>_loading = false );
          widget.onSuccess() ;
          Navigator.pop(context);
        }

    );
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      child: Container(
        height: 190,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            DeliveryTextField(
              label: "pin_code".tr(),
              hint: "pin_code_ex".tr(),
              width: width / 1.1,
              labelColor: Colors.black,
              backGroundColor: Color(0x33000000),
              textType: TextInputType.number,
              controller: _code,

            ),
            Text("$errorMsg" , style: TextStyle(color: Colors.red , fontSize: 14 , fontWeight: FontWeight.bold) ,),
            SizedBox(
              height: 8,
            ),
            DeliveryButton(
              width: width / 1.2,
              height: 40,
              textColor: Colors.white,
              text: "add".tr(),
              onPressed: _addCode,
              loading: _loading,
            ),
            SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}