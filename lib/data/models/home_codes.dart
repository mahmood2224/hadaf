import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeCodeResponse {
  List<Code> codes;
  String message;
  int status;

  HomeCodeResponse({this.codes, this.message, this.status});

  factory HomeCodeResponse.fromJson(Map<String, dynamic> json) {
    return HomeCodeResponse(
      codes: json['data'] != null
          ? (json['data'] as List).map((i) => Code.fromJson(i)).toList()
          : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.codes != null) {
      data['data'] = this.codes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Code {
  String account_code;
  String account_name;
  String created_at;
  int id;
  String pin_code;
  String updated_at;
  int user_id;

  Code(
      {this.account_code,
      this.account_name,
      this.created_at,
      this.id,
      this.pin_code,
      this.updated_at,
      this.user_id});

  factory Code.fromJson(Map<String, dynamic> json) {
    return Code(
      account_code: json['account_code'],
      account_name: json['account_name'],
      created_at: json['created_at'],
      id: json['id'],
      pin_code: json['pin_code'],
      updated_at: json['updated_at'],
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_code'] = this.account_code;
    data['account_name'] = this.account_name;
    data['created_at'] = this.created_at;
    data['id'] = this.id;
    data['pin_code'] = this.pin_code;
    data['updated_at'] = this.updated_at;
    data['user_id'] = this.user_id;
    return data;
  }
}

class CodeResponse {
  CodeServer code;
  String message;
  int status;

  CodeResponse({this.code, this.message, this.status});

  factory CodeResponse.fromJson(Map<String, dynamic> json) {
    return CodeResponse(
      code: json['data'] == null ? null : CodeServer.fromJson(json['data']),
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.code != null) {
      data['data'] = this.code.toJson();
    }
    return data;
  }
}

class CodeServer {
  String accountCode;
  String accountName;
  String adress;
  int balance;
  int countAll;
  int countDeleverAll;
  int countDeleverNotTasdeed;
  int countDeleverTasdeed;
  int countInProcess;
  int countPending;
  int countReturenAll;
  int countReturenClient;
  String phonNo;
  String pinCode;

  CodeServer(
      {this.accountCode,
      this.accountName,
      this.adress,
      this.balance,
      this.countAll,
      this.countDeleverAll,
      this.countDeleverNotTasdeed,
      this.countDeleverTasdeed,
      this.countInProcess,
      this.countPending,
      this.countReturenAll,
      this.countReturenClient,
      this.phonNo,
      this.pinCode});

  factory CodeServer.fromJson(Map<String, dynamic> json) {
    return CodeServer(
      accountCode: "${json['accountCode']}",
      accountName: json['accountName'],
      adress: json['adress'],
      balance: json['balance'],
      countAll: json['countAll'],
      countDeleverAll: json['countDeleverAll'],
      countDeleverNotTasdeed: json['countDeleverNotTasdeed'],
      countDeleverTasdeed: json['countDeleverTasdeed'],
      countInProcess: json['countInProcess'],
      countPending: json['countPending'],
      countReturenAll: json['countReturenAll'],
      countReturenClient: json['countReturenClient'],
      phonNo: json['phonNo'],
      pinCode: "${json['pinCode']}",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountCode'] = this.accountCode;
    data['accountName'] = this.accountName;
    data['adress'] = this.adress;
    data['balance'] = this.balance;
    data['countAll'] = this.countAll;
    data['countDeleverAll'] = this.countDeleverAll;
    data['countDeleverNotTasdeed'] = this.countDeleverNotTasdeed;
    data['countDeleverTasdeed'] = this.countDeleverTasdeed;
    data['countInProcess'] = this.countInProcess;
    data['countPending'] = this.countPending;
    data['countReturenAll'] = this.countReturenAll;
    data['countReturenClient'] = this.countReturenClient;
    data['phonNo'] = this.phonNo;
    data['pinCode'] = this.pinCode;
    return data;
  }
}

class CodesTypes {
  static const int PENDING = 1;
  static const int IN_PROGRESS = 2;
  static const int DELIVERED = 6;
  static const int RETURNED = 4;
  static const int RETURNED_CLIENT = 5;
  static const int DELIVERED_PAID = 3;


  static String getTypeName(int type) {
    switch (type) {
      case PENDING:
        return "pending".tr();
      case IN_PROGRESS:
        return "in_progress".tr();
      case DELIVERED:
        return "deliverd".tr();
      case RETURNED:
        return "returned".tr();
      case RETURNED_CLIENT:
        return "returned_client".tr();
      case DELIVERED_PAID:
        return "deliverd_paid".tr();
      default:
        return "";
    }
  }


  static Color getTypeColor(int type) {
      switch (type) {
          case PENDING:
              return Color(0xffFFAB03);
          case IN_PROGRESS:
              return Color(0xff9738F6);
          case DELIVERED:
              return Color(0xff009E4A);
          case RETURNED:
              return Color(0xffC50004);
          case RETURNED_CLIENT:
              return Color(0xff919191);
          case DELIVERED_PAID:
              return Color(0xff0065EF);
          default:
              return Colors.black;
      }
  }


  static String getTypeIcon(int type) {
    switch (type) {
      case PENDING:
        return "assets/images/pinding_icon.png";
      case IN_PROGRESS:
        return "assets/images/on_progress_icon.png";
      case DELIVERED:
        return "assets/images/deliverd_icon.png";
      case RETURNED:
        return"assets/images/returned_icon.png";
      case RETURNED_CLIENT:
        return "assets/images/returned_client_icon.png";
      case DELIVERED_PAID:
        return "assets/images/paid_icon.png";
      default:
        return "assets/images/pending.png";
    }
  }


}


