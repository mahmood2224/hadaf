import 'dart:async';
import 'dart:math';

import 'package:hadaf/data/api_provider.dart';
import 'package:hadaf/data/models/auth_send_model.dart';
import 'package:hadaf/data/Localization.dart';
import 'package:hadaf/data/data_constatnts.dart';
import 'package:hadaf/data/models/auth_model.dart';
import 'package:hadaf/data/models/auth_send_model.dart';
import 'package:hadaf/data/models/counts_model.dart';
import 'package:hadaf/data/models/generalModel.dart';
import 'package:hadaf/data/models/home_codes.dart';
import 'package:hadaf/data/models/node_code_response.dart';
import 'package:hadaf/data/models/node_order_response.dart';
import 'package:hadaf/data/models/node_zone_model.dart';
import 'package:hadaf/data/models/notification_models.dart';
import 'package:hadaf/data/models/order_model.dart';
import 'package:hadaf/data/models/status_model.dart';
import 'package:hadaf/data/models/zones.dart';
import 'package:hadaf/data/userData.dart';
import 'package:hadaf/ui/views/filter_page.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:easy_localization/easy_localization.dart';

class NodeApiProvider{
  static void getCode(
      {@required String code, @required String branchId , @required String phoneNum, onSuccess(), onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    //data
    String params = "?pin_code=$code&phone_num=$phoneNum&branch_id=$branchId";
    print("$GET_ACCOUNT_URL$params");
    http.Response response = await http.get("$GET_ACCOUNT_URL$params", headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "createCode",
        statusCode: response.statusCode,
        response: decoded,
        data: null,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
    NodeCodeResponse responseModel =
    decoded == null ? null : NodeCodeResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      ApiProvider.addCode(code: code, codeData: responseModel.data , onSuccess: onSuccess , onError: onError);
    } else {
      onError(responseModel.message);
    }
  }


  static void getCodeCounts(
      {@required String accountId, onSuccess(List<Count> counts), onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    //data
    String params = "?account_id=$accountId";
    print("$GET_COUNTS_URL$params");
    http.Response response = await http.get("$GET_COUNTS_URL$params", headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "get counts",
        statusCode: response.statusCode,
        response: decoded,
        data: null,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
    CountsModelResponse responseModel =
    decoded == null ? null : CountsModelResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      onSuccess(responseModel.data);
    } else {
      onError(responseModel.message);
    }
  }

  static void getOrders(
      {@required String accountId,@required int status, String phoneNum  , int zoneId ,onSuccess(List<NodeOrder> orders), onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    //data
    String params = "?account_id=$accountId&status=$status";
    if(phoneNum != null )
      params+="&phone_num=$phoneNum";
    if(zoneId != null)
      params+="&zone_id=$zoneId";
    print("$GET_ORDERS_URL$params");
    http.Response response = await http.get("$GET_ORDERS_URL$params", headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "get orders",
        statusCode: response.statusCode,
        response: decoded,
        data: null,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
    NodeOrderResponse responseModel =
    decoded == null ? null : NodeOrderResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      onSuccess(responseModel.data);
    } else {
      onError(responseModel.message);
    }
  }

  static void getZones(
      { onSuccess(List<NodeZone> zones), onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    //data
    print("$GET_ZONES");
    http.Response response = await http.get("$GET_ZONES", headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "get zones",
        statusCode: response.statusCode,
        response: decoded,
        data: null,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
    NodeZoneResponse responseModel =
    decoded == null ? null : NodeZoneResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      onSuccess(responseModel.data);
    } else {
      onError(responseModel.message);
    }
  }
}