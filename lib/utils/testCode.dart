/*
 PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            child: Container(
              height: 300,
              color: PRIMARY_COLOR,
              child: Column(
                children: [
                  Container(
                    height: 80,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        title: Text(
                            "${widget.code?.account_name ?? ""} - ${widget.code?.pin_code ?? ""}"),
                        centerTitle: true,
                      ),
                    ),
                  ),

                  Container(
                    height: (this.status?.balance??0) == 0 ? 40:90,
                    padding: EdgeInsets.symmetric(horizontal: 23),
                    child: Column(
                      children: [
                        ...(this.status?.balance??0) == 0 ? []:[Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "wallet".tr(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0x80ffffff),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '${code?.balance ?? 0.0}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ],
                        ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            height: 1,
                            width: width,
                            color: Color(0x4Dffffff),
                          ),],
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "total_order".tr(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0x80ffffff),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '${code?.countAll ?? 0}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                  // for making anther designs in header
                ],
              ),
            ),
          ),
 */