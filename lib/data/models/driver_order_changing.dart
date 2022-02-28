
import 'package:flutter/cupertino.dart';

const int ORDER_DELIVERED = 1 ;
const int ORDER_RETURNED = 2 ;
const int ORDER_PARTIAL_RETURNED = 3 ;
const int ORDER_EDIT_PRICE = 4 ;
const int ORDER_SEND_NOTE = 5;

class DriverOrderChangingSend{
  int type ;
  String price ;
  String note ;
  int orderId ;
  int clientType;


  DriverOrderChangingSend({@required this.type, this.price,this.clientType, this.note, @required this.orderId});

  Map<String, dynamic > getJsonData(){
    Map<String,dynamic> data = new Map() ;
    data['order_id'] = this.orderId;
    data['type'] = this.type ;
    if(price != null) data['price'] = price ;
    if(note != null) data['desc'] = this.note ;
    if(clientType != null) data['client_type'] = this.clientType ;

    return data ;
  }
}