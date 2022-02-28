import 'package:flutter/material.dart';
import '/data/api_provider.dart';
import '/data/models/auth_send_model.dart';
import '/ui/views/home.dart';
import '/ui/widgets/delivery_button.dart';
import '/ui/widgets/delivery_text_field.dart';
import '/ui/widgets/logo.dart';
import '/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _userName = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _companyName = new TextEditingController();
  TextEditingController _email = new TextEditingController();

  bool _loading = false;

  String errorMsg = "";

  @override
  void initState() {
    super.initState();
  }

  _register() {
    setState(() {
      _loading = true;
      errorMsg = "";
    });
    ApiProvider.register(
        body: AuthSendModel(
            userName: _userName.text,
            password: _password.text,
            confirmPassword: _password.text,
            companyName: _companyName.text,
            phone: _phone.text,
//            email: _email.text
        ),
        onError: (error) => setState(() {
              _loading = false;
              errorMsg = error;
            }),
        onSuccess: () {
          setState(() => _loading = false);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Home()),
              (route) => false);
        });
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
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              Center(child: Logo(width: 80 , height: 100, isAuth: true,)),
              SizedBox(height: 32,),
              Text(
                "register_text".tr(),
                style: TextStyle(
                    fontSize: 22,

                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              DeliveryTextField(
                label: "user_name".tr(),
                hint: "ex_user_name".tr(),
                controller: _userName,
                width: width / 1.1,
              ),
//                    SizedBox(
//                      height: 8,
//                    ),
//                    DeliveryTextField(
//                      label: "email".tr(),
//                      hint: "ex_email".tr(),
//                      controller: _email,
//                      width: width / 1.1,
//                    ),
              SizedBox(
                height: 8,
              ),
              DeliveryTextField(
                label: "company_name".tr(),
                hint: "ex_company".tr(),
                controller: _companyName,
                width: width / 1.1,
              ),
              SizedBox(
                height: 8,
              ),
              DeliveryTextField(
                label: "phone".tr(),
                hint: "ex_phone".tr(),
                width: width / 1.1,
                controller: _phone,
                textType: TextInputType.phone,
              ),
              SizedBox(
                height: 8,
              ),
              DeliveryTextField(
                label: "password".tr(),
                hint: "ex_password".tr(),
                controller: _password,
                obscure: true,
                width: width / 1.1,
              ),
              Text(
                "$errorMsg",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Center(
                child: DeliveryButton(
                  width: width / 1.3,
                  height: 40,
                  textColor: Colors.white,
                  text: "register".tr(),
                  onPressed: _register,
                  loading: _loading,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Center(
                child: DeliveryButton(
                  width: width / 1.3,
                  height: 40,
                  textColor: PRIMARY_COLOR,
                  border: Border.all(color: PRIMARY_COLOR , width: 1),
                  background: Colors.white,
                  text: "sign_in_now".tr(),
                  onPressed: ()=> Navigator.of(context).pop(),
                ),
              ),
              SizedBox(
                height: 16,
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


/*
*
*               Text(
                "register_text".tr(),
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                "register_desc".tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              DeliveryTextField(
                label: "user_name".tr(),
                hint: "ex_user_name".tr(),
                controller: _userName,
                width: width / 1.1,
              ),
              SizedBox(
                height: 8,
              ),
              DeliveryTextField(
                label: "email".tr(),
                hint: "ex_email".tr(),
                controller: _email,
                width: width / 1.1,
              ),
              SizedBox(
                height: 8,
              ),
              DeliveryTextField(
                label: "company_name".tr(),
                hint: "ex_company".tr(),
                controller: _companyName,
                width: width / 1.1,
              ),
              SizedBox(
                height: 8,
              ),
              DeliveryTextField(
                label: "phone".tr(),
                hint: "ex_phone".tr(),
                width: width / 1.1,
                controller: _phone,
                textType: TextInputType.phone,
              ),
              SizedBox(
                height: 8,
              ),
              DeliveryTextField(
                label: "password".tr(),
                hint: "ex_password".tr(),
                controller: _password,
                obscure: true,
                width: width / 1.1,
              ),
              Text(
                "$errorMsg",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              DeliveryButton(
                width: width / 1.2,
                height: 40,
                textColor: Colors.white,
                text: "register".tr(),
                onPressed: _register,
                loading: _loading,
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                width: width / 1.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "have_account".tr(),
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Text(
                          "sign_in_now".tr(),
                          style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff5B4EF8),
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
*
* */