import 'dart:async';

import '/data/models/auth_send_model.dart';
import '/data/Localization.dart';
import '/data/data_constatnts.dart';
import '/data/models/auth_model.dart';
import '/data/models/auth_send_model.dart';
import '/data/models/generalModel.dart';
import '/data/models/home_codes.dart';
import '/data/models/node_code_response.dart';
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


  static void addCode(
      {@required String code, @required NodeCode codeData, onSuccess(), onError(String error)}) async {
    try{
      //API Calling
      String lang = await getLanguage();
      String token = await getToken();
      var headers;
      headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

      //data
      var data = json.encode({"pin_code": code , "account_code" : codeData.account_id , "account_name" : codeData.full_name , "type" : codeData.type});
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
    }catch(e){
      onError("$e");
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




  static void getDomain(
      {onSuccess(DomainModel statuses),
        onError()}) async {
    //API Calling
    String lang = await getLanguage();
    String token = await getToken();
    var headers;
    headers = {"Authorization": "Bearer $token", "lang": lang, ...apiHeaders};

    http.Response response = await http.get(
        "$BASE_URL$DOMAIN_END_POINT",
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
      DomainResponse responseData = DomainResponse.fromJson(decoded);
    if (isValidResponse(response.statusCode) && responseData.status == 1 ) {
      onSuccess(responseData.data);
    } else {
      onError();
    }
  }
}
