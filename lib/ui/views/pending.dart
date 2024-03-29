import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/data/api_provider.dart';
import '/data/models/counts_model.dart';
import '/data/models/driver_order_changing.dart';
import '/data/models/home_codes.dart';
import '/data/models/node_order_response.dart';
import '/data/models/order_model.dart';
import '/data/node_api_provider.dart';
import '/ui/views/filter_page.dart';
import '/ui/views/product.dart';
import '/ui/views/product_details.dart';
import '/ui/widgets/Loading.dart';
import '/ui/widgets/app_bar.dart';
import '/ui/widgets/delivery_button.dart';
import '/ui/widgets/delivery_text_field.dart';
import '/ui/widgets/logo.dart';
import '/utils/Config.dart';
import '/utils/Dialog.dart';
import '/utils/Messages.dart';
import '/utils/algorithms.dart';
import '/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Pending extends StatefulWidget {
  String accountId;
  int status;
  String name;
  int type;
  Count cont;
  Pending(this.type, {this.status, this.accountId, this.name, this.cont});

  @override
  _PendingState createState() {
    return _PendingState();
  }
}

class _PendingState extends State<Pending> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _loading = false;

  List<NodeOrder> orders = [];
  TextEditingController _textController = new TextEditingController();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int balance = 0;
  int shippingBalance = 0;
  int salaries = 0;
  int net = 0;
  @override
  void initState() {
    super.initState();
    _getOrders();
    print("***************************${widget.type}");
  }

  _getOrders(
      {bool isRefresh = false, String phoneNum, int zoneId, String billNum}) {
    setState(() => _loading = true);
    NodeApiProvider.getOrders(widget.type,
        accountId: widget.accountId,
        status: widget.status,
        billNum: billNum,
        phoneNum: (phoneNum?.isEmpty ?? true) ? null : phoneNum,
        zoneId: zoneId,
        onError: (error) => setState(() => _loading = false),
        onSuccess: (orders) => setState(() {
              this.balance = 0;
              this.shippingBalance = 0;
              this.net = 0;
              this.salaries = 0;
              _loading = false;
              this.orders = orders;
              this.orders.forEach((element) => setState(() {
                    this.balance += element?.total_price ?? 0;
                    this.shippingBalance += element?.total_cost_shipping ?? 0;
                    this.salaries += element?.price_shipping ?? 0;
                    this.net += element?.total_Price_client ?? 0;
                  }));
            }));
    if (isRefresh) _refreshController.refreshCompleted();
  }

  _showOptions(NodeOrder order) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0))),
        context: context,
        builder: (builder) {
          return Container(
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 5,
                  width: width / 3,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    launchURL("tel://${order?.account_phone}");
                  },
                  child: Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          child: Image.asset(
                            "assets/images/client.png",
                            width: 36,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "connect_with_client".tr(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    width: width,
                    height: 1,
                    color: Colors.black12,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    launchURL("tel://${order?.phone_resiver}");
                  },
                  child: Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          child: Image.asset(
                            "assets/images/user.png",
                            width: 36,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "connect_with_receiver".tr(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    width: width,
                    height: 1,
                    color: Colors.black12,
                  ),
                ),
                InkWell(
                  onTap: () => _inputDialog(order?.id, ORDER_PARTIAL_RETURNED),
                  child: Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          child: Image.asset(
                            "assets/images/back.png",
                            width: 36,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "partial_returned".tr(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    width: width,
                    height: 1,
                    color: Colors.black12,
                  ),
                ),
                InkWell(
                  onTap: () => _inputDialog(order?.id, ORDER_EDIT_PRICE),
                  child: Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          child: Image.asset(
                            "assets/images/money.png",
                            width: 36,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "edit_price".tr(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    width: width,
                    height: 1,
                    color: Colors.black12,
                  ),
                ),
                InkWell(
                  onTap: () => _inputDialog(order?.id, ORDER_SEND_NOTE),
                  child: Container(
                    height: 45,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          child: Image.asset(
                            "assets/images/note.png",
                            width: 36,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "add_note".tr(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          );
        });
  }

  _showDataModel() {
    double width = MediaQuery.of(context).size.width;
    ShowDialog(
        context: context,
        height: 260,
        radius: BorderRadius.circular(16),
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            Text(
              "الاحصائيات",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 33, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/num_order.png",
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "  اجمالي الطلبات  ",
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              '${this.orders?.length ?? 0}' +
                                  " " +
                                  "order".tr(),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.grey,
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/balance.png",
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "wallet".tr(),
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              convertNumbersString('${this.balance ?? 0}') +
                                  " " +
                                  "cr".tr(),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 33, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/num_order.png",
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "اجمالي اجور التوصيل",
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              convertNumbersString(
                                      '${this.shippingBalance ?? 0}') +
                                  " " +
                                  "cr".tr(),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.grey,
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/balance.png",
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "صافي المطلوب",
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              convertNumbersString(
                                      '${(this.balance ?? 0) - (this.shippingBalance ?? 0)}') +
                                  " " +
                                  "cr".tr(),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Spacer()
                ],
              ),
            ),
          ],
        ));
  }

  _changeOrderStatus(int orderId, int type, {String note, String price}) {
    _loadingDialog();
    NodeApiProvider.changeOrderStatus(
        DriverOrderChangingSend(
            type: type,
            orderId: orderId,
            price: price,
            clientType: widget.type,
            note: note), onSuccess: (message) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      showInSnackBar(
          value: message,
          scaffoldKey: _scaffoldKey,
          messageType: MessageType.SUCCESS);
      this._getOrders();
    }, onError: (error) {
      Navigator.pop(context);
      showInSnackBar(
          value: error,
          scaffoldKey: _scaffoldKey,
          messageType: MessageType.ERROR);
    });
  }

  _inputDialog(int orderId, int type) {
    double width = MediaQuery.of(context).size.width;
    ShowDialog(
        context: context,
        height: type == ORDER_SEND_NOTE ? 260 : 180,
        radius: BorderRadius.circular(16),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              DeliveryTextField(
                label: type == ORDER_SEND_NOTE ? "note".tr() : "price".tr(),
                hint: type == ORDER_SEND_NOTE ? "note".tr() : "price".tr(),
                liens: type == ORDER_SEND_NOTE ? 4 : 1,
                width: width / 1.1,
                labelColor: Colors.black,
                backGroundColor: Color(0x33000000),
                textType: TextInputType.text,
                controller: _textController,
              ),
              SizedBox(
                height: 16,
              ),
              DeliveryButton(
                width: width / 1.5,
                height: 40,
                textColor: Colors.white,
                text: "add".tr(),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  _changeOrderStatus(orderId, type,
                      note:
                          type == ORDER_SEND_NOTE ? _textController.text : null,
                      price: type == ORDER_SEND_NOTE
                          ? null
                          : _textController.text);
                  _textController.text = "";
                },
                loading: _loading,
              ),
            ],
          ),
        ),
        alignment: Alignment.center);
  }

  _loadingDialog() {
    double width = MediaQuery.of(context).size.width;
    ShowDialog(
        context: context,
        height: 100,
        dismiss: false,
        radius: BorderRadius.circular(16),
        child: Container(
          color: Colors.white,
            child: Center(
          child: Text(
            "من فضلك انتظر جاري التحميل ...",
            style: TextStyle(fontSize: 14),
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar:
          HadafAppBar(context, title: "${widget.name ?? "البحث"}", actions: [
        IconButton(
            icon: Icon(
              FontAwesomeIcons.filter,
              size: 20,
            ),
            onPressed: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FilterPage((FilterResult result) {
                            String phone = result.type == FilterTypes.BY_PHONE
                                ? result?.value
                                : null;
                            String billNum = result.type == FilterTypes.BY_ID
                                ? result?.value
                                : null;
                            _getOrders(
                                phoneNum: phone,
                                zoneId: result?.zone?.zoon_id,
                                billNum: billNum);
                          })))
                })
      ]),
      body: Container(
        height: height,
        decoration: BoxDecoration(
            color: Color(0xffF4F6FA), borderRadius: BorderRadius.circular(16)),
        child: _loading
            ? Loading()
            : this.orders.isEmpty
                ? Center(
                    child: Text(
                      "no_data".tr(),
                      style: TextStyle(color: PRIMARY_COLOR, fontSize: 14),
                    ),
                  )
                : Container(
                    child: SmartRefresher(
                      controller: _refreshController,
                      onRefresh: () => _getOrders(isRefresh: true),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            InkWell(
                              onTap: widget.type == DRIVER
                                  ? _showDataModel
                                  : () {},
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 33, vertical: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Spacer(),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/images/num_order.png",
                                            height: 24,
                                            width: 24,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "orders".tr(),
                                                style: TextStyle(fontSize: 12),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                '${this.orders?.length ?? 0}' +
                                                    " " +
                                                    "order".tr(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                    Spacer(),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            "assets/images/balance.png",
                                            height: 24,
                                            width: 24,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "wallet".tr(),
                                                style: TextStyle(fontSize: 12),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                convertNumbersString(
                                                        '${this.balance ?? 0}') +
                                                    " " +
                                                    "cr".tr(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Spacer()
                                  ],
                                ),
                              ),
                            ),
                            widget.type == CLIENT
                                ? InkWell(
                                    onTap: widget.type == DRIVER
                                        ? _showDataModel
                                        : () {},
                                    child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 33, vertical: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  "assets/images/num_order.png",
                                                  height: 24,
                                                  width: 24,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "صافي",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    Text(
                                                      '${this.net ?? 0}' +
                                                          " " +
                                                          "cr".tr(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            height: 50,
                                            width: 1,
                                            color: Colors.grey,
                                          ),
                                          Spacer(),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Image.asset(
                                                  "assets/images/balance.png",
                                                  height: 24,
                                                  width: 24,
                                                ),
                                                SizedBox(
                                                  width: 4,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "الاجور",
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                    Text(
                                                      convertNumbersString(
                                                              '${this.salaries ?? 0}') +
                                                          " " +
                                                          "cr".tr(),
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Spacer()
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            SizedBox(
                              height: 8,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              itemCount: this.orders?.length ?? 0,
                              itemBuilder: (context, index) {
                                NodeOrder order = this.orders[index];

                                return InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetails(
                                              order, widget.cont , type: widget.type,))),
                                  child: Container(
                                    width: width,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "number_order".tr(),
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0x4D232446),
                                                            ),
                                                          ),
                                                          Text(
                                                            '${order?.shiping_Nr ?? 00000}',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xff232446),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // InkWell(
                                            //   onTap: () => launchURL(
                                            //       "tel://${order?.phone_resiver}"),
                                            //   child: Container(
                                            //     width: 127,
                                            //     height: 32,
                                            //     padding: EdgeInsets.symmetric(
                                            //         horizontal: 20),
                                            //     decoration: BoxDecoration(
                                            //         color: widget?.cont?.color,
                                            //         borderRadius:
                                            //             BorderRadius.circular(
                                            //                 30)),
                                            //     child: Row(
                                            //       children: [
                                            //         Icon(
                                            //           Icons.phone,
                                            //           size: 15,
                                            //           color: Colors.white,
                                            //         ),
                                            //         SizedBox(
                                            //           width: 8,
                                            //         ),
                                            //         Text(
                                            //           "call_reciver".tr(),
                                            //           style: TextStyle(
                                            //               fontSize: 10,
                                            //               fontWeight:
                                            //                   FontWeight.w500,
                                            //               color: Colors.white),
                                            //         )
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      convertNumbersString(
                                                          '${order?.total_price ?? 0.0}'),
                                                      style: TextStyle(
                                                        fontSize: 21,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        right: 16),
                                                    child: Text(
                                                      'cr'.tr(),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0xff000000),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 5),
                                          height: 1,
                                          width: width,
                                          color: Color(0x26000000),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "date_order".tr(),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0x4D232446),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                '${order?.date?.split("T")[0] ?? ""}',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff232446),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 5),
                                          height: 1,
                                          width: width,
                                          color: Color(0x26000000),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "Address".tr(),
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            Color(0x4D232446),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Text(
                                                "${order?.adress_another ?? ""}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xff232446),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 5),
                                          height: 1,
                                          width: width,
                                          color: Color(0x26000000),
                                        ),
                                        widget.type == DRIVER
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          child: Text(
                                                            "حالة السائق",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0x4D232446),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      CodesTypes.getTypeName(order
                                                          ?.New_State_Driver),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: CodesTypes
                                                            .getTypeColor(order
                                                                ?.New_State_Driver),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        widget.type == DRIVER
                                            ? Container()
                                            : Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                height: 1,
                                                width: width,
                                                color: Color(0x26000000),
                                              ),
                                        ((widget.type ?? CLIENT) == DRIVER &&
                                                (widget.cont?.status) !=
                                                    CodesTypes.DRIVER_PAID)
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  (widget?.cont?.status ==
                                                          CodesTypes.DELIVERED)
                                                      ? Container()
                                                      : Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      8),
                                                          child: DeliveryButton(
                                                            width: (width -
                                                                        32 -
                                                                        32 -
                                                                        45) /
                                                                    2 -
                                                                16,
                                                            height: 45,
                                                            background:
                                                                Colors.green,
                                                            text:
                                                                "deliverd".tr(),
                                                            onPressed: () {
                                                              _changeOrderStatus(
                                                                  order?.id,
                                                                  ORDER_DELIVERED);
                                                            },
                                                          ),
                                                        ),
                                                  (widget?.cont?.status ==
                                                          CodesTypes.RETURNED)
                                                      ? Container()
                                                      : DeliveryButton(
                                                          width: (width -
                                                                      32 -
                                                                      32 -
                                                                      45) /
                                                                  2 -
                                                              16,
                                                          background: widget
                                                              .cont?.color
                                                              ?.withOpacity(.3),
                                                          textColor: widget
                                                              ?.cont?.color,
                                                          height: 45,
                                                          text: "returned".tr(),
                                                          onPressed: () {
                                                            _changeOrderStatus(
                                                                order?.id,
                                                                ORDER_RETURNED);
                                                          },
                                                        ),
                                                  Spacer(),
                                                  InkWell(
                                                    onTap: () =>
                                                        _showOptions(order),
                                                    child: Container(
                                                      width: 45,
                                                      height: 45,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color:
                                                              Colors.black12),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.more_horiz,
                                                          color: Colors.grey,
                                                          size: 25,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(),
                                                  Container(
                                                    width: 50,
                                                    height: 32,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color:
                                                            widget.cont?.color),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.arrow_forward,
                                                        color: Colors.white,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
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
