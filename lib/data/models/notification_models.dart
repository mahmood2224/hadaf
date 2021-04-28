class NotificationResponse {
    List<SingleNotification> notifications;
    String message;
    int status;

    NotificationResponse({this.notifications, this.message, this.status});

    factory NotificationResponse.fromJson(Map<String, dynamic> json) {
        return NotificationResponse(
          notifications: json['data'] != null ? (json['data'] as List).map((i) => SingleNotification.fromJson(i)).toList() : null,
            message: json['message'], 
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['status'] = this.status;
        if (this.notifications != null) {
            data['data'] = this.notifications.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class SingleNotification {
    String created_at;
    String desc;
    int for_all;
    int id;
    String title;
    String updated_at;
    int user_id;

    SingleNotification({this.created_at, this.desc, this.for_all, this.id, this.title, this.updated_at, this.user_id});

    factory SingleNotification.fromJson(Map<String, dynamic> json) {
        return SingleNotification(
            created_at: json['created_at'], 
            desc: json['desc'], 
            for_all: json['for_all'], 
            id: json['id'], 
            title: json['title'], 
            updated_at: json['updated_at'], 
            user_id: json['user_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['desc'] = this.desc;
        data['for_all'] = this.for_all;
        data['id'] = this.id;
        data['title'] = this.title;
        data['updated_at'] = this.updated_at;
        data['user_id'] = this.user_id;
        return data;
    }
}