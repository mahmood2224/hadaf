import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/data/models/counts_model.dart';
import '/data/models/home_codes.dart';
import '/data/models/node_order_notes_respones.dart';
import '/data/models/node_order_response.dart';
import '/data/models/order_model.dart';
import '/data/node_api_provider.dart';
import '/ui/views/product.dart';
import '/ui/widgets/app_bar.dart';
import '/ui/widgets/delivery_button.dart';
import '/ui/widgets/logo.dart';
import '/ui/widgets/notes_dialog.dart';
import '/utils/Config.dart';
import '/utils/Dialog.dart';
import '/utils/algorithms.dart';
import '/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';

class ProductDetails extends StatefulWidget {
  NodeOrder order;
  Count code;
  int type ;

  ProductDetails(this.order, this.code , {this.type});

  @override
  _ProductDetailsState createState() {
    return _ProductDetailsState();
  }
}

class _ProductDetailsState extends State<ProductDetails> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: HadafAppBar(context,
          title:
              "Product_details".tr() + " - ${widget.order?.shiping_Nr ?? ""}"),
      body: Container(
        height: height,
        decoration: BoxDecoration(
            color: Color(0xffF4F6FA), borderRadius: BorderRadius.circular(16)),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  color: widget.code?.color,
                  height: 48,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.code?.status_name}",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: width,
                  color: Colors.white,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/id_icon.png",
                                  width: 32,
                                  height: 32,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "number_order".tr(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0x4D232446),
                                      ),
                                    ),
                                    Text(
                                      '${widget?.order?.shiping_Nr ?? 00000}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff232446),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            DeliveryButton(
                              background: Colors.black26,
                              width: 127,
                              height: 37,
                              text: "الملاحظات",
                              textColor: Colors.black45,
                              onPressed: (){
                                ShowDialog(
                                  context: context ,
                                  height: height-80,
                                  radius: BorderRadius.circular(20),
                                  child: NotesDialog(widget.order?.id , widget.type)
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: width,
                        height: 1,
                        color: Colors.black12,
                        margin: EdgeInsets.only(right: 40),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "date_order".tr() + " : ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${widget.order?.date?.split("T")[0]}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: width,
                        height: 1,
                        color: Colors.black12,
                        margin: EdgeInsets.only(right: 40),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "area".tr() + " : ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${widget.order?.province_name ?? ""} - ${widget.order?.zoon_name ?? ""}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: width,
                        height: 1,
                        color: Colors.black12,
                        margin: EdgeInsets.only(right: 40),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Address".tr() + " : ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${widget.order?.adress_another ?? ""}",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: width,
                        height: 1,
                        color: Colors.black12,
                        margin: EdgeInsets.only(right: 40),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "phone_client".tr() + " : ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                            InkWell(
                              onTap: () => launchURL(
                                  "tel://${widget?.order?.phone_resiver}"),
                              child: Container(
                                width: 127,
                                height: 32,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                    color: PRIMARY_COLOR,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "${widget?.order?.phone_resiver}",
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  color: Colors.white,
                  width: width,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/note_icon.png",
                        width: 32,
                        height: 32,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        width: width - 32 - 12 - 32,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "الملاحظة",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Text("${widget.order?.adress_resiver}",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  color: Colors.white,
                  width: width,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "assets/images/balance.png",
                            width: 32,
                            height: 32,
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Container(
                            width: width - 32 - 12 - 32,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total_price".tr(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                                Text(
                                  convertNumbersString("${widget.order?.total_price}") +" "+ "cr".tr(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: width,
                        height: 1,
                        color: Colors.black12,
                        margin: EdgeInsets.only(right: 40),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Shipping".tr() + " : ",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              convertNumbersString("${widget.order?.price_shipping}"),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: width,
                  color: Colors.white,
                  height: 80,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.order?.with_phone == null
                          ? Container()
                          : InkWell(
                              onTap: () =>
                                  launchURL("tel://${widget.order?.with_phone}"),
                              child: Container(
                                height: 48,
                                width: (width / 2) - 32 - 8,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color:PRIMARY_20, width: 1),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 84,
                                      width: 48,
                                      decoration: BoxDecoration(
                                          color: PRIMARY_20,
                                          borderRadius: BorderRadius.horizontal(
                                              right: Radius.circular(12))),
                                      child: Center(
                                        child: Icon(
                                          Icons.phone,
                                          color: PRIMARY_COLOR,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: (width / 2) - 32 - 8 - 50,
                                      child: Center(
                                        child: Text(
                                          "call_driver".tr(),
                                          style: TextStyle(
                                              color: PRIMARY_COLOR,
                                              fontSize: 12),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                      SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () =>
                            launchURL("tel://${widget.order?.account_phone}"),
                        child: Container(
                          height: 48,
                          width: (width / 2) - 32 - 8,
                          decoration: BoxDecoration(
                              color: PRIMARY_COLOR,
                              border: Border.all(
                                  color: PRIMARY_20, width: 1),
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 84,
                                width: 48,
                                decoration: BoxDecoration(
                                    color: PRIMARY_50,
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(12))),
                                child: Center(
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                width: (width / 2) - 32 - 8 - 50,
                                child: Center(
                                  child: Text(
                                    "call_client".tr(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
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
