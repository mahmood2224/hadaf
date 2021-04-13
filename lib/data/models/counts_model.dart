import 'package:flutter/cupertino.dart';
import 'package:hadaf/data/models/home_codes.dart';

class CountsModelResponse {
    List<Count> data;
    String message;
    int status;

    CountsModelResponse({this.data, this.message, this.status});

    factory CountsModelResponse.fromJson(Map<String, dynamic> json) {
        return CountsModelResponse(
            data: json['data'] != null ? (json['data'] as List).map((i) => Count.fromJson(i)).toList() : null,
            message: json['message'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['status'] = this.status;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Count {
    int count;
    int status;
    String status_name;
    Color color ;
    String icon ;

    Count({this.count, this.status, this.status_name ,this.color ,this.icon});

    factory Count.fromJson(Map<String, dynamic> json) {
        return Count(
            count: json['count'], 
            status: json['status'], 
            status_name: json['status_name'],
            color: CodesTypes.getTypeColor(json['status']),
            icon: CodesTypes.getTypeIcon(json['status'])
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['count'] = this.count;
        data['status'] = this.status;
        data['status_name'] = this.status_name;
        return data;
    }
}