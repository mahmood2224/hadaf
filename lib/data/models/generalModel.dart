class GeneralModel {
    String message;
    int status;

    GeneralModel({this.message, this.status});

    factory GeneralModel.fromJson(Map<String, dynamic> json) {
        return GeneralModel(
            message: json['message'],
            status: json['status'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['status'] = this.status;
        return data;
    }
}