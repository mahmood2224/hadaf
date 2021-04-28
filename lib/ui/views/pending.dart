import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hadaf/data/api_provider.dart';
import 'package:hadaf/data/models/order_model.dart';
import 'package:hadaf/ui/views/filter_page.dart';
import 'package:hadaf/ui/views/product.dart';
import 'package:hadaf/ui/views/product_details.dart';
import 'package:hadaf/ui/widgets/Loading.dart';
import 'package:hadaf/ui/widgets/app_bar.dart';
import 'package:hadaf/ui/widgets/logo.dart';
import 'package:hadaf/utils/Config.dart';
import 'package:hadaf/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Pending extends StatefulWidget {
  CodeModel code;
  String accountNum;
  FilterResult filterResult;

  Pending({this.code, this.accountNum, this.filterResult});

  @override
  _PendingState createState() {
    return _PendingState();
  }
}

class _PendingState extends State<Pending> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _loading = false;

  int _pageNum = 1;
  int _maxPages = 1;

  List<Order> orders = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ScrollController controller;

  int balance = 0;
  @override
  void initState() {
    super.initState();
    if (widget.filterResult == null)
      _getOrders();
    else
      _getOrdersFilter(widget.filterResult);
    controller = new ScrollController()..addListener(_scrollListener);
  }

  _getOrders({bool isRefresh = false}) {
    setState(() => _loading = true);
    ApiProvider.getOrders(
        accountNum: widget.accountNum,
        status: widget.code.code,
        onError: (error) => setState(() => _loading = false),
        onSuccess: (orders) => setState(() {
              _loading = false;
              this.orders = orders;
              this.balance =  0;
              this.orders.forEach((element) =>
                  setState(() => this.balance += element?.totalPrice ?? 0.0));
            }));
    if (isRefresh) _refreshController.refreshCompleted();
  }

  _getOrdersFilter(FilterResult result) {
    setState(() => _loading = true);
    ApiProvider.getOrdersFilter(
        accountNum: widget.accountNum,
        result: result,
        onError: (error) => setState(() => _loading = false),
        onSuccess: (orders) => setState(() {
              _loading = false;
              this.orders = orders;
            }));
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 200) {
      this._pageNum++;
      if (this._pageNum > this._maxPages) return;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: HadafAppBar(context, title: "${widget.code?.name ?? "البحث"}"),
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
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 33, vertical: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 40),
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
                                              '${widget.code?.count ?? 0}' +
                                                  "order".tr(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 40),
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
                                              '${this.balance ?? 0}  ' +
                                                  "cr".tr(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            ListView.builder(
                              controller: controller,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              itemCount: this.orders?.length ?? 0,
                              itemBuilder: (context, index) {
                                Order order = this.orders[index];
                                return InkWell(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetails(order ,widget.code))),
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
                                                            '${order?.shipingNr ?? 00000}',
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
                                            InkWell(
                                              onTap: () => launchURL(
                                                  "tel://${order?.phoneResiver}"),
                                              child: Container(
                                                width: 127,
                                                height: 32,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                decoration: BoxDecoration(
                                                    color: PRIMARY_COLOR,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
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
                                                      "call_reciver".tr(),
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white),
                                                    )
                                                  ],
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
                                                "${order?.adressResiver ?? ""}",
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
                                                      '${order?.totalPrice ?? 0.0}',
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
                                            Container(
                                              width: 50,
                                              height: 32,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: widget.code?.codeColor),
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
