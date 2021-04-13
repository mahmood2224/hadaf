class NodeCodeResponse {
    NodeCode data;
    String message;
    int status;

    NodeCodeResponse({this.data, this.message, this.status});

    factory NodeCodeResponse.fromJson(Map<String, dynamic> json) {
        return NodeCodeResponse(
            data: json['data'] != null ? NodeCode.fromJson(json['data']) : null,
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

class NodeCode {
    int account_id;
    String full_name;
    int type;

    NodeCode({this.account_id, this.full_name, this.type});

    factory NodeCode.fromJson(Map<String, dynamic> json) {
        return NodeCode(
            account_id: json['account_id'], 
            full_name: json['full_name'], 
            type: json['type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['account_id'] = this.account_id;
        data['full_name'] = this.full_name;
        data['type'] = this.type;
        return data;
    }
}