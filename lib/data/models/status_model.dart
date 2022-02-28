class DomainResponse {
    DomainModel data;
    String message;
    int status;

    DomainResponse({this.data, this.message, this.status});

    factory DomainResponse.fromJson(Map<String, dynamic> json) {
        return DomainResponse(
            data: json['data'] != null ? DomainModel.fromJson(json['data']) : null,
            message: json['message'], 
            status: json['status'], 
        );
    }


}

class DomainModel {
    String domain ;


    DomainModel({this.domain});

  factory DomainModel.fromJson(Map<String, dynamic> json) {
        return DomainModel(
            domain: json['domain'],
        );
    }

}