class NodeZoneResponse {
    List<NodeZone> data;
    String message;
    int status;

    NodeZoneResponse({this.data, this.message, this.status});

    factory NodeZoneResponse.fromJson(Map<String, dynamic> json) {
        return NodeZoneResponse(
            data: json['data'] != null ? (json['data'] as List).map((i) => NodeZone.fromJson(i)).toList() : null,
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

class NodeZone {
    bool active_staet;
    String color_row;
    int driver_code;
    String driver_name;
    int id;
    int province_code;
    String prvovince_name;
    int zoon_cost;
    int zoon_id;
    String zoon_name;
    int zoon_price;

    NodeZone({this.active_staet, this.color_row, this.driver_code, this.driver_name, this.id, this.province_code, this.prvovince_name, this.zoon_cost, this.zoon_id, this.zoon_name, this.zoon_price});

    factory NodeZone.fromJson(Map<String, dynamic> json) {
        return NodeZone(
            active_staet: json['active_staet'], 
            color_row: json['color_row'], 
            driver_code: json['driver_code'], 
            driver_name: json['driver_name'], 
            id: json['id'], 
            province_code: json['province_code'], 
            prvovince_name: json['prvovince_name'], 
            zoon_cost: json['zoon_cost'], 
            zoon_id: json['zoon_id'], 
            zoon_name: json['zoon_name'], 
            zoon_price: json['zoon_price'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['active_staet'] = this.active_staet;
        data['color_row'] = this.color_row;
        data['driver_code'] = this.driver_code;
        data['driver_name'] = this.driver_name;
        data['id'] = this.id;
        data['province_code'] = this.province_code;
        data['prvovince_name'] = this.prvovince_name;
        data['zoon_cost'] = this.zoon_cost;
        data['zoon_id'] = this.zoon_id;
        data['zoon_name'] = this.zoon_name;
        data['zoon_price'] = this.zoon_price;
        return data;
    }
}