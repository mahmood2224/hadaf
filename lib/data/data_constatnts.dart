//BASE URL declaration
import 'package:flutter/cupertino.dart';
// 'http://192.168.1.13:8090'
const String BASE_URL = 'http://api.new.hadaf.apishipping.iraq-soft.info/';
const String ZONE_FULL_URL = 'http://104.207.130.151/shippingapi/api/tzoa';
String BASE_URL_NODE = 'http://192.168.1.2:8080';
const String NODE_TOKEN ="xaljlkjdasfjsad_fasdklfjsalkjf35154sad3f51sdafsjafdhjas" ;


bindDomain(String domain){
  BASE_URL_NODE = domain ;
}

//Static Headers
const Map<String, String> apiHeaders = {
  "Content-Type": "application/json",
  "Accept": "application/json, text/plain, */*",
  "X-Requested-With": "XMLHttpRequest",
};

//api/auth_apis.dart end_points
const String LOGIN_END_POINT = "api/Auth_general/login";
const String REGISTER_END_POINT = "api/Auth_general/register";
const String HOME_END_POINT = "api/code/get";
const String CREATE_CODE_END_POINT = "api/code/create";


const String REMOVE_CODE_END_POINT = "api/code/remove";
const String ORDERS_END_POINT = "api/code/orders/get";
const String NOTIFICATIONS_END_POINT = "api/Auth_private/notification";
const String FCMTOKEN_END_POINT = "api/Auth_private/save_fcmToken";
const String ORDERS_FILTER_END_POINT = "api/code/orders/get/filter";
const String DOMAIN_END_POINT = "api/settings/get-domain";

//Node Apis
 String GET_COUNTS_URL = "$BASE_URL_NODE/api/orders/count/$NODE_TOKEN";
 String GET_ORDERS_URL = "$BASE_URL_NODE/api/orders/get/$NODE_TOKEN";
 String GET_ORDERS_NOTES_URL = "$BASE_URL_NODE/api/orders/notes/$NODE_TOKEN";
 String GET_ACCOUNT_URL = "$BASE_URL_NODE/api/accounts/$NODE_TOKEN";
 String GET_ZONES = "$BASE_URL_NODE/api/zones/get/$NODE_TOKEN";
 String POST_CHANGE_ORDER = "$BASE_URL_NODE/api/order/changing/$NODE_TOKEN";



////////////////////////////////////////////////////////////////////////////////
//////////////////////////////// Helpers Functions /////////////////////////////
bool isValidResponse(int statusCode) {
  return statusCode >= 200 && statusCode <= 302;
}

void debugApi(
    {String fileName = "ApiProvider.dart",
    @required String methodName,
    @required int statusCode,
    @required response,
    @required data,
    @required endPoint,
    headers}) {
  debugPrint(
    "FileName: $fileName\n"
    "Method: $methodName\n"
    "${endPoint != null ? 'URL: $endPoint\n' : ''}"
    "${data != null ? 'data: $data\n' : ''}"
    "${headers != null ? "Headerss :$headers\n" : ""}"
    "statusCode: $statusCode\n"
    "${response != null ? 'Response: $response\n' : ''}"
    "--------------------",
    wrapWidth: 512,
  );
}
