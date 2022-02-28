import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import '/data/api_provider.dart';
import '/data/node_api_provider.dart';
import '/ui/widgets/delivery_button.dart';
import '/ui/widgets/delivery_text_field.dart';
import 'package:easy_localization/easy_localization.dart';

class AddPinCode extends StatefulWidget {
  Function onSuccess;

  AddPinCode({this.onSuccess});

  @override
  _AddPinCodeState createState() {
    return _AddPinCodeState();
  }
}

class _AddPinCodeState extends State<AddPinCode> {
  bool _loading = false;

  TextEditingController _code = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  // TextEditingController _branch = new TextEditingController();

  String errorMsg = "";
  @override
  void initState() {
    super.initState();
  }

  _addCode() {
    setState(() {
      _loading = true;
      errorMsg = "";
    });
    NodeApiProvider.getCode(
        code: _code.text,
        phoneNum: _phone.text,
        branchId: "1",
        onError: (error) {
          showToast(error ,backgroundColor: Colors.red);
          setState(() {
            _loading = false;
            errorMsg = error;
          });
        },
        onSuccess: () {
          setState(() => _loading = false);
          widget.onSuccess();
          Navigator.pop(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Material(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              "اضف كود جديد",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(
              height: 8,
            ),
            DeliveryTextField(
              label: "pin_code".tr(),
              hint: "pin_code_ex".tr(),
              width: width / 1.1,
              labelColor: Colors.black,
              backGroundColor: Color(0x33000000),
              textType: TextInputType.phone,
              controller: _code,
            ),
            SizedBox(
              height: 16,
            ),
            DeliveryTextField(
              label: "phone_num".tr(),
              hint: "phone_num_ex".tr(),
              width: width / 1.1,
              labelColor: Colors.black,
              backGroundColor: Color(0x33000000),
              textType: TextInputType.phone,
              controller: _phone,
            ),
            // SizedBox(
            //   height: 16,
            // ),
            // DeliveryTextField(
            //   label: "branch_id".tr(),
            //   hint: "branch_id_ex".tr(),
            //   width: width / 1.1,
            //   labelColor: Colors.black,
            //   backGroundColor: Color(0x33000000),
            //   textType: TextInputType.number,
            //   controller: _branch,
            //
            // ),
            Text(
              "$errorMsg",
              style: TextStyle(
                  color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
            ),
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
