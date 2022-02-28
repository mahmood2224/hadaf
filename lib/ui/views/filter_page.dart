import 'package:flutter/material.dart';
import '/data/api_provider.dart';
import '/data/models/counts_model.dart';
import '/data/models/node_zone_model.dart';
import '/data/models/zones.dart';
import '/ui/views/pending.dart';
import '/ui/widgets/Loading.dart';
import '/ui/widgets/auto_complete_text_field.dart';
import '/ui/widgets/delivery_button.dart';
import '/ui/widgets/delivery_drop_down.dart';
import '/ui/widgets/delivery_text_field.dart';
import '/utils/Config.dart';
import '/utils/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import '/data/node_api_provider.dart';

class FilterPage extends StatefulWidget {
  Function onResponse ;

  FilterPage(this.onResponse);

  @override
  _FilterPageState createState() {
    return _FilterPageState();
  }
}

class _FilterPageState extends State<FilterPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _searchText = new TextEditingController();
  TextEditingController _zoneText = new TextEditingController();
  int _selectedRadio = 1;
  bool _isZones = false ;
  List<NodeZone> zones = [] ;
  FilterResult _result = new FilterResult() ;
  List<ItemModel> filterValues = [
    ItemModel(name: "filter_by_name".tr(), value: FilterTypes.BY_PHONE),
    ItemModel(name: "filter_by_id".tr(), value: FilterTypes.BY_ID),
    ItemModel(name: "flutter_by_zosne".tr(), value: FilterTypes.BY_ZONE),
  ];
  @override
  void initState() {
    super.initState();
    _getZones() ;
  }
  _getZones() {
    NodeApiProvider.getZones(onError: (error){} , onSuccess: (zones)=>setState((){
      this.zones = zones ;
    }));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
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
                        title: Text("filter".tr()),
                        centerTitle: true,
                      ),
                    ),
                  ),
//                  Container()
                  // for making anther designs in header
                ],
              ),
            ),
          ),
          PositionedDirectional(
            top: 90,
            start: 0,
            end: 0,
            bottom: 0,
            child: Container(
              height: height - 90,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Color(0xffF4F6FA),
                  borderRadius: BorderRadius.circular(16)),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   _isZones ?DeliveryDropdown(
                     height: 45,
                     width: width/1.2,
                      items: [DropDownModel(name: "من فضلك اختر المنطقة", object: null) , ...this.zones.map((e) => DropDownModel(name: e.zoon_name , object: e)).toList()],
                     onSelectItem: (value){
                        _result.zone = value ;
                     },
                   ) : DeliveryTextField(
                      label: "search_text".tr(),
                      hint: "ex_search".tr(),
                      obscure: false,
                      width: width / 1.1,
                      textType: TextInputType.phone,
                      backGroundColor: Color(0x33000000),
                      labelColor: Colors.black,
                      controller: _searchText,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      height: filterValues.length * 36.0,
                      child: Column(
                        children: filterValues.map((item) {
                          return Container(
                            child: Container(
                              height: 35,
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Radio(
                                        value: item.value,
                                        groupValue: _selectedRadio,
                                        onChanged: (int val) => setState(() {
                                              this._selectedRadio = val;
                                              _isZones = this._selectedRadio == FilterTypes.BY_ZONE ;
                                            })),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      item.name,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 80,
        child: Center(
          child: DeliveryButton(
            text: "search".tr(),
            onPressed: (){
              _result.type = _selectedRadio ;
              _result.value = _searchText.text ;
              Navigator.pop(context);
              widget.onResponse(_result);

            },
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

class ItemModel {
  String name;
  int value;

  ItemModel({this.name, this.value});
}

class FilterResult {
  String value ;
  NodeZone zone ;
  int type ;

  FilterResult({this.value, this.zone, this.type});

}
