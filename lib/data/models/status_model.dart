class StatusResponse {
    Status data;
    String message;
    int status;

    StatusResponse({this.data, this.message, this.status});

    factory StatusResponse.fromJson(Map<String, dynamic> json) {
        return StatusResponse(
            data: json['data'] != null ? Status.fromJson(json['data']) : null,
            message: json['message'], 
            status: json['status'], 
        );
    }


}

class Status {
    int delivered;
    int delivered_paid;
    int on_progress;
    int pending;
    int returned;
    int returned_client;
    int balance ;

    Status({this.delivered,this.balance ,  this.delivered_paid, this.on_progress, this.pending, this.returned, this.returned_client});

    factory Status.fromJson(Map<String, dynamic> json) {
        return Status(
            delivered: json['delivered'], 
            delivered_paid: json['delivered_paid'], 
            on_progress: json['on_progress'], 
            pending: json['pending'], 
            returned: json['returned'], 
            returned_client: json['returned_client'],
            balance: json['balance']
        );
    }

}