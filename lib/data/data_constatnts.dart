//BASE URL declaration
import 'package:flutter/cupertino.dart';

const String BASE_URL = 'http://api.hadaf.apishipping.iraq-soft.info/';
const String ZONE_FULL_URL = 'http://104.207.130.151/shippingapi/api/tzoa';
const String BASE_URL_NODE = 'http://192.168.1.13:8090';
const String NODE_TOKEN ="xaljlkjdasfjsad_fasdklfjsalkjf35154sad3f51sdafsjafdhjas" ;

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
const String STATUS_END_POINT = "api/settings/get-status";

//Node Apis
const String GET_COUNTS_URL = "$BASE_URL_NODE/api/orders/count/$NODE_TOKEN";
const String GET_ORDERS_URL = "$BASE_URL_NODE/api/orders/get/$NODE_TOKEN";
const String GET_ACCOUNT_URL = "$BASE_URL_NODE/api/accounts/$NODE_TOKEN";
const String GET_ZONES = "$BASE_URL_NODE/api/zones/get/$NODE_TOKEN";



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
