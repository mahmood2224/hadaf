import 'dart:async';

import 'package:hadaf/data/models/auth_send_model.dart';
import 'package:hadaf/data/Localization.dart';
import 'package:hadaf/data/data_constatnts.dart';
import 'package:hadaf/data/models/auth_model.dart';
import 'package:hadaf/data/models/auth_send_model.dart';
import 'package:hadaf/data/models/generalModel.dart';
import 'package:hadaf/data/models/home_codes.dart';
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

class ApiProvider {
  static void login(
      {@required AuthSendModel body,
      onSuccess(),
      onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"lang": lang, ...apiHeaders};

    //data handling
    var data = json.encode(body.toJson());
    http.Response response = await http.post("$BASE_URL$LOGIN_END_POINT",
        body: data, headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "login",
        statusCode: response.statusCode,
        response: decoded,
        data: data,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
    AuthResponse responseModel =
        decoded == null ? null : AuthResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      await setUserData(data: responseModel.data);
      onSuccess();
    } else {
      onError(responseModel.message);
    }
  }

  static void saveFcmToken(
      {@required String firebaseToken,
      onSuccess(),
      onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    //data handling
    var data = json.encode({
      "fcm_token":firebaseToken
    });
    http.Response response = await http.post("$BASE_URL$FCMTOKEN_END_POINT",
        body: data, headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "save Token ",
        statusCode: response.statusCode,
        response: decoded,
        data: data,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
    AuthResponse responseModel =
        decoded == null ? null : AuthResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      onSuccess();
    } else {
      onError(responseModel.message);
    }
  }

  static void register(
      {@required AuthSendModel body,
      onSuccess(),
      onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"lang": lang, ...apiHeaders};

    //data handling
    var data = json.encode(body.toJson());
    http.Response response = await http.post("$BASE_URL$REGISTER_END_POINT",
        body: data, headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "register",
        statusCode: response.statusCode,
        response: decoded,
        data: data,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
    AuthResponse responseModel =
        decoded == null ? null : AuthResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      await setUserData(data: responseModel.data);
      onSuccess();
    } else {
      onError(responseModel.message);
    }
  }

  static void home({onSuccess(List<Code> codes), onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    http.Response response =
        await http.get("$BASE_URL$HOME_END_POINT", headers: headers);



    // Debugging API response
    debugApi(
        methodName: "home",
        statusCode: response.statusCode,
        response: response.body,
        data: null,
        endPoint: response.request.url,
        headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    //exporting data into model
    HomeCodeResponse responseModel =
        decoded == null ? null : HomeCodeResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      onSuccess(responseModel.codes);
    } else {
      onError(responseModel.message);
    }
  }

  static void getNotifications(
      {onSuccess(List<SingleNotification> notifications),
      onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    http.Response response =
        await http.get("$BASE_URL$NOTIFICATIONS_END_POINT", headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "get Notifications",
        statusCode: response.statusCode,
        response: decoded,
        data: null,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
    NotificationResponse responseModel =
        decoded == null ? null : NotificationResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      onSuccess(responseModel.notifications);
    } else {
      onError(responseModel.message);
    }
  }

  static void singleCode(
      {String pinCode,
      onSuccess(CodeServer code),
      onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    http.Response response =
        await http.get("$BASE_URL$HOME_END_POINT/$pinCode", headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "Single Code",
        statusCode: response.statusCode,
        response: decoded,
        data: null,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
    CodeResponse responseModel =
        decoded == null ? null : CodeResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      onSuccess(responseModel.code);
    } else {
      onError(responseModel.message);
    }
  }

  static void addCode(
      {@required String code, onSuccess(), onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    //data
    var data = json.encode({"pin_code": code});
    http.Response response = await http.post("$BASE_URL$CREATE_CODE_END_POINT",
        body: data, headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "createCode",
        statusCode: response.statusCode,
        response: decoded,
        data: data,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
    GeneralModel responseModel =
        decoded == null ? null : GeneralModel.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      onSuccess();
    } else {
      onError(responseModel.message);
    }
  }

  static void removeCode(
      {@required String codeId, onSuccess(), onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    //data
    var data = json.encode({"code_id": codeId});
    http.Response response = await http.post("$BASE_URL$REMOVE_CODE_END_POINT",
        body: data, headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "removeCode",
        statusCode: response.statusCode,
        response: decoded,
        data: data,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
    GeneralModel responseModel =
    decoded == null ? null : GeneralModel.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      onSuccess();
    } else {
      onError(responseModel.message);
    }
  }

  static void getOrders(
      {@required String accountNum,
      @required int status,
      onSuccess(List<Order> orders),
      onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    //data
    http.Response response = await http.get(
        "$BASE_URL$ORDERS_END_POINT?account_num=$accountNum&status=$status",
        headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "getOrders",
        statusCode: response.statusCode,
        response: decoded,
        data: null,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
    OrderResponse responseModel =
        decoded == null ? null : OrderResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      onSuccess(responseModel.data);
    } else {
      onError(responseModel.message);
    }
  }

  static void getOrdersFilter(
      {@required String accountNum,
        @required FilterResult result,
        onSuccess(List<Order> orders),
        onError(String error)}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    //data
    var data = json.encode({
      "account_num" : accountNum ,
      "zone_id" : result?.zone?.id ,
      "id" :result?.value,
      "phone_number" :result?.value,
      "type" : result.type
    });
    http.Response response = await http.post(
        "$BASE_URL$ORDERS_FILTER_END_POINT",
        body: data,
        headers: headers);

    // Decoding Response.
    Map<String, dynamic> decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "getOrdersWithFilter",
        statusCode: response.statusCode,
        response: decoded,
        data: data,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
    OrderResponse responseModel =
    decoded == null ? null : OrderResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseModel.status == 1) {
      onSuccess(responseModel.data);
    } else {
      onError(responseModel.message);
    }
  }


  static void getZones(
      {onSuccess(List<ZoneModel> zones),
        onError()}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    //data
    http.Response response = await http.get(
        "$ZONE_FULL_URL",
        headers: headers);

    // Decoding Response.
    final decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "getZones",
        statusCode: response.statusCode,
        response: decoded,
        data: null,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
    List<ZoneModel> zones =
    decoded == null ? [] : (decoded as List).map((e) => ZoneModel.fromJson(e)).toList();
    if (isValidResponse(response.statusCode) ) {
      onSuccess(zones);
    } else {
      onError();
    }
  }

  static void getStatus(
      {onSuccess(Status statuses),
        onError()}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    //data
    http.Response response = await http.get(
        "$BASE_URL$STATUS_END_POINT",
        headers: headers);

    // Decoding Response.
    final decoded = json.decode(response.body);

    // Debugging API response
    debugApi(
        methodName: "get status",
        statusCode: response.statusCode,
        response: decoded,
        data: null,
        endPoint: response.request.url,
        headers: headers);

    //exporting data into model
      StatusResponse responseData = StatusResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseData.status == 1 ) {
      onSuccess(responseData.data);
    } else {
      onError();
    }
  }
}
