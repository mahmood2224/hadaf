import 'dart:async';
import 'dart:math';

import '/data/api_provider.dart';
import '/data/models/auth_send_model.dart';
import '/data/Localization.dart';
import '/data/data_constatnts.dart';
import '/data/models/auth_model.dart';
import '/data/models/auth_send_model.dart';
import '/data/models/counts_model.dart';
import '/data/models/driver_order_changing.dart';
import '/data/models/generalModel.dart';
import '/data/models/home_codes.dart';
import '/data/models/node_code_response.dart';
import '/data/models/node_order_response.dart';
import '/data/models/node_zone_model.dart';
import '/data/models/notification_models.dart';
import '/data/models/order_model.dart';
import '/data/models/status_model.dart';
import '/data/models/zones.dart';
import '/data/userData.dart';
import '/ui/views/filter_page.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:easy_localization/easy_localization.dart';

import 'models/node_order_notes_respones.dart';

class NodeApiProvider{
  static void getCode(
      {@required String code, @required String branchId , @required String phoneNum, onSuccess(), onError(String error)}) async {
    try{
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
    }catch(e){
      onError("ناسف لوجود عطل حاول لاحقا");
    }
  }


  static void getCodeCounts(int type ,
      {@required String accountId, onSuccess(List<Count> counts), onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    //data
    String params = "?account_id=$accountId&type=$type";
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

  static void getOrders(int type ,
      {@required String accountId, int status, String phoneNum  , int zoneId ,String billNum,onSuccess(List<NodeOrder> orders), onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    //data
    String params = "?account_id=$accountId&type=$type";

    if(phoneNum != null )
      params+="&phone_num=$phoneNum";

    if(status != null )
      params+="&status=$status";

    if(billNum != null )
      params+="&bill_num=$billNum";

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

  static void getNotes( int orderId,
      { onSuccess(List<NodeOrderNote> notes), onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    print("$GET_ORDERS_NOTES_URL?order_id=$orderId");
    //data
    http.Response response = await http.get("$GET_ORDERS_NOTES_URL?order_id=$orderId", headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "get notes",
        statusCode: response.statusCode,
        response: decoded,
        data: null,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
NoteOrderNotestResponse responseModel =
    decoded == null ? null : NoteOrderNotestResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      onSuccess(responseModel.data);
    } else {
      onError(responseModel.message);
    }
  }

  static void changeOrderStatus(DriverOrderChangingSend data ,
      {onSuccess(String message), onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    //data
    var body = json.encode(data.getJsonData());
    print(body);
    print("$POST_CHANGE_ORDER");
    http.Response response = await http.post("$POST_CHANGE_ORDER",body: body, headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "change data",
        statusCode: response.statusCode,
        response: decoded,
        data: body,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
    NodeZoneResponse responseModel =
    decoded == null ? null : NodeZoneResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      onSuccess(responseModel.message);
    } else {
      onError(responseModel.message);
    }
  }
}