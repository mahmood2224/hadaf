class NoteOrderNotestResponse {
    List<NodeOrderNote> data;
    String message;
    int status;

    NoteOrderNotestResponse({this.data, this.message, this.status});

    factory NoteOrderNotestResponse.fromJson(Map<String, dynamic> json) {
        return NoteOrderNotestResponse(
            data: json['data'] != null ? (json['data'] as List).map((i) => NodeOrderNote.fromJson(i)).toList() : null,
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

class NodeOrderNote {
    int bill_nr;
    int code_order;
    String dateenter;
    int id;
    String notes;
    bool state_active;
    String user_name;

    NodeOrderNote({this.bill_nr, this.code_order, this.dateenter, this.id, this.notes, this.state_active, this.user_name});

    factory NodeOrderNote.fromJson(Map<String, dynamic> json) {
        return NodeOrderNote(
            bill_nr: json['bill_nr'],
            code_order: json['code_order'],
            dateenter: json['dateenter'],
            id: json['id'],
            notes: json['notes'],
            state_active: json['state_active'],
            user_name: json['user_name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bill_nr'] = this.bill_nr;
        data['code_order'] = this.code_order;
        data['dateenter'] = this.dateenter;
        data['id'] = this.id;
        data['notes'] = this.notes;
        data['state_active'] = this.state_active;
        data['user_name'] = this.user_name;
        return data;
    }
}