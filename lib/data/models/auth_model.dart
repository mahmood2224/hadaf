class AuthResponse {
    AuthModel data;
    String message;
    int status;

    AuthResponse({this.data, this.message, this.status});

    factory AuthResponse.fromJson(Map<String, dynamic> json) {
        return AuthResponse(
            data: json['data'] != null ? AuthModel.fromJson(json['data']) : null,
            message: json['message'],
            status: json['status'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['status'] = this.status;
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        return data;
    }
}

class AuthModel {
    String company_name;
    String created_at;
    String email;
    String fCM_token;
    int id;
    String lang;
    int message;
    int notification;
    String phone;
    int status;
    String token;
    String updated_at;
    String user_name;

    AuthModel({this.company_name, this.created_at, this.email, this.fCM_token, this.id, this.lang, this.message, this.notification, this.phone, this.status, this.token, this.updated_at, this.user_name});

    factory AuthModel.fromJson(Map<String, dynamic> json) {
        return AuthModel(
            company_name: json['company_name'],
            created_at: json['created_at'],
            email: json['email'],
            fCM_token: json['fCM_token'],
            id: json['id'],
            lang: json['lang'],
            message: json['message'],
            notification: json['notification'],
            phone: json['phone'],
            status: json['status'],
            token: json['token'],
            updated_at: json['updated_at'],
            user_name: json['user_name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['company_name'] = this.company_name;
        data['created_at'] = this.created_at;
        data['email'] = this.email;
        data['fCM_token'] = this.fCM_token;
        data['id'] = this.id;
        data['lang'] = this.lang;
        data['message'] = this.message;
        data['notification'] = this.notification;
        data['phone'] = this.phone;
        data['status'] = this.status;
        data['token'] = this.token;
        data['updated_at'] = this.updated_at;
        data['user_name'] = this.user_name;
        return data;
    }
}