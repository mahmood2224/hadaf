class NodeOrderResponse {
    List<NodeOrder> data;
    String message;
    int status;

    NodeOrderResponse({this.data, this.message, this.status});

    factory NodeOrderResponse.fromJson(Map<String, dynamic> json) {
        return NodeOrderResponse(
            data: json['data'] != null ? (json['data'] as List).map((i) => NodeOrder.fromJson(i)).toList() : null,
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

class NodeOrder {
    int account_id;
    String account_name;
    String account_phone;
    String account_pincode;
    bool active_del;
    int additional_cost_shipping;
    int additional_price_goods;
    int additional_price_shipping;
    String adress_another;
    String adress_resiver;
    String adress_sender;
    int bill_Sanad_D;
    int bill_Sanad_T;
    int bill_nr;
    int box_Driver;
    int box_client;
    int branch_id;
    String branch_name;
    bool check_Driver;
    bool check_doubel;
    bool check_good;
    bool check_late;
    bool check_price;
    String company_code;
    int cost_shipping;
    String date;
    String date_process;
    int delever_Client;
    int delever_Driver;
    int goods_New;
    bool iS_SEND;
    int id;
    String lantidue;
    String lantuide;
    String note_Back;
    String phone_resiver;
    int price_New;
    int price_goods;
    int price_shipping;
    String province_name;
    int provinice_id;
    int qTY;
    String resiver_name;
    bool row;
    String sender_name;
    String shiping_Nr;
    bool show;
    String state_Cleint;
    int state_deleiver_id;
    String state_deliver_name;
    String state_driver;
    String state_name;
    int state_payment_id;
    bool state_print;
    String time_process;
    int total_Price_client;
    int total_cost;
    int total_cost_shipping;
    int total_driver;
    int total_price;
    int total_price_shipping;
    int total_prophet;
    int type_goods;
    String type_goods_name;
    String user_name;
    String view_historey;
    int view_state_id;
    String view_state_name;
    int weight;
    int with_id;
    String with_name;
    String with_phone;
    String with_pincode;
    int zoon_id;
    String zoon_name;

    NodeOrder({this.account_id, this.account_name, this.account_phone, this.account_pincode, this.active_del, this.additional_cost_shipping, this.additional_price_goods, this.additional_price_shipping, this.adress_another, this.adress_resiver, this.adress_sender, this.bill_Sanad_D, this.bill_Sanad_T, this.bill_nr, this.box_Driver, this.box_client, this.branch_id, this.branch_name, this.check_Driver, this.check_doubel, this.check_good, this.check_late, this.check_price, this.company_code, this.cost_shipping, this.date, this.date_process, this.delever_Client, this.delever_Driver, this.goods_New, this.iS_SEND, this.id, this.lantidue, this.lantuide, this.note_Back, this.phone_resiver, this.price_New, this.price_goods, this.price_shipping, this.province_name, this.provinice_id, this.qTY, this.resiver_name, this.row, this.sender_name, this.shiping_Nr, this.show, this.state_Cleint, this.state_deleiver_id, this.state_deliver_name, this.state_driver, this.state_name, this.state_payment_id, this.state_print, this.time_process, this.total_Price_client, this.total_cost, this.total_cost_shipping, this.total_driver, this.total_price, this.total_price_shipping, this.total_prophet, this.type_goods, this.type_goods_name, this.user_name, this.view_historey, this.view_state_id, this.view_state_name, this.weight, this.with_id, this.with_name, this.with_phone, this.with_pincode, this.zoon_id, this.zoon_name});

    factory NodeOrder.fromJson(Map<String, dynamic> json) {
        return NodeOrder(
            account_id: json['account_id'], 
            account_name: json['account_name'], 
            account_phone: json['account_phone'], 
            account_pincode: json['account_pincode'], 
            active_del: json['active_del'], 
            additional_cost_shipping: json['additional_cost_shipping'], 
            additional_price_goods: json['additional_price_goods'], 
            additional_price_shipping: json['additional_price_shipping'], 
            adress_another: json['adress_another'], 
            adress_resiver: json['adress_resiver'], 
            adress_sender: json['adress_sender'], 
            bill_Sanad_D: json['bill_Sanad_D'], 
            bill_Sanad_T: json['bill_Sanad_T'], 
            bill_nr: json['bill_nr'], 
            box_Driver: json['box_Driver'], 
            box_client: json['box_client'], 
            branch_id: json['branch_id'], 
            branch_name: json['branch_name'], 
            check_Driver: json['check_Driver'], 
            check_doubel: json['check_doubel'], 
            check_good: json['check_good'], 
            check_late: json['check_late'], 
            check_price: json['check_price'], 
            company_code: json['company_code'], 
            cost_shipping: json['cost_shipping'], 
            date: json['date'], 
            date_process: json['date_process'], 
            delever_Client: json['delever_Client'], 
            delever_Driver: json['delever_Driver'], 
            goods_New: json['goods_New'], 
            iS_SEND: json['iS_SEND'], 
            id: json['id'], 
            lantidue: json['lantidue'], 
            lantuide: json['lantuide'], 
            note_Back: json['note_Back'], 
            phone_resiver: json['phone_resiver'], 
            price_New: json['price_New'], 
            price_goods: json['price_goods'], 
            price_shipping: json['price_shipping'], 
            province_name: json['province_name'], 
            provinice_id: json['provinice_id'], 
            qTY: json['qTY'], 
            resiver_name: json['resiver_name'], 
            row: json['row'], 
            sender_name: json['sender_name'], 
            shiping_Nr: json['shiping_Nr'], 
            show: json['show'], 
            state_Cleint: json['state_Cleint'], 
            state_deleiver_id: json['state_deleiver_id'], 
            state_deliver_name: json['state_deliver_name'], 
            state_driver: json['state_driver'], 
            state_name: json['state_name'], 
            state_payment_id: json['state_payment_id'], 
            state_print: json['state_print'], 
            time_process: json['time_process'], 
            total_Price_client: json['total_Price_client'], 
            total_cost: json['total_cost'], 
            total_cost_shipping: json['total_cost_shipping'], 
            total_driver: json['total_driver'], 
            total_price: json['total_price'], 
            total_price_shipping: json['total_price_shipping'], 
            total_prophet: json['total_prophet'], 
            type_goods: json['type_goods'], 
            type_goods_name: json['type_goods_name'], 
            user_name: json['user_name'], 
            view_historey: json['view_historey'], 
            view_state_id: json['view_state_id'], 
            view_state_name: json['view_state_name'], 
            weight: json['weight'], 
            with_id: json['with_id'], 
            with_name: json['with_name'], 
            with_phone: json['with_phone'], 
            with_pincode: json['with_pincode'], 
            zoon_id: json['zoon_id'], 
            zoon_name: json['zoon_name'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['account_id'] = this.account_id;
        data['account_name'] = this.account_name;
        data['account_phone'] = this.account_phone;
        data['account_pincode'] = this.account_pincode;
        data['active_del'] = this.active_del;
        data['additional_cost_shipping'] = this.additional_cost_shipping;
        data['additional_price_goods'] = this.additional_price_goods;
        data['additional_price_shipping'] = this.additional_price_shipping;
        data['adress_another'] = this.adress_another;
        data['adress_resiver'] = this.adress_resiver;
        data['adress_sender'] = this.adress_sender;
        data['bill_Sanad_D'] = this.bill_Sanad_D;
        data['bill_Sanad_T'] = this.bill_Sanad_T;
        data['bill_nr'] = this.bill_nr;
        data['box_Driver'] = this.box_Driver;
        data['box_client'] = this.box_client;
        data['branch_id'] = this.branch_id;
        data['branch_name'] = this.branch_name;
        data['check_Driver'] = this.check_Driver;
        data['check_doubel'] = this.check_doubel;
        data['check_good'] = this.check_good;
        data['check_late'] = this.check_late;
        data['check_price'] = this.check_price;
        data['company_code'] = this.company_code;
        data['cost_shipping'] = this.cost_shipping;
        data['date'] = this.date;
        data['date_process'] = this.date_process;
        data['delever_Client'] = this.delever_Client;
        data['delever_Driver'] = this.delever_Driver;
        data['goods_New'] = this.goods_New;
        data['iS_SEND'] = this.iS_SEND;
        data['id'] = this.id;
        data['lantidue'] = this.lantidue;
        data['lantuide'] = this.lantuide;
        data['note_Back'] = this.note_Back;
        data['phone_resiver'] = this.phone_resiver;
        data['price_New'] = this.price_New;
        data['price_goods'] = this.price_goods;
        data['price_shipping'] = this.price_shipping;
        data['province_name'] = this.province_name;
        data['provinice_id'] = this.provinice_id;
        data['qTY'] = this.qTY;
        data['resiver_name'] = this.resiver_name;
        data['row'] = this.row;
        data['sender_name'] = this.sender_name;
        data['shiping_Nr'] = this.shiping_Nr;
        data['show'] = this.show;
        data['state_Cleint'] = this.state_Cleint;
        data['state_deleiver_id'] = this.state_deleiver_id;
        data['state_deliver_name'] = this.state_deliver_name;
        data['state_driver'] = this.state_driver;
        data['state_name'] = this.state_name;
        data['state_payment_id'] = this.state_payment_id;
        data['state_print'] = this.state_print;
        data['time_process'] = this.time_process;
        data['total_Price_client'] = this.total_Price_client;
        data['total_cost'] = this.total_cost;
        data['total_cost_shipping'] = this.total_cost_shipping;
        data['total_driver'] = this.total_driver;
        data['total_price'] = this.total_price;
        data['total_price_shipping'] = this.total_price_shipping;
        data['total_prophet'] = this.total_prophet;
        data['type_goods'] = this.type_goods;
        data['type_goods_name'] = this.type_goods_name;
        data['user_name'] = this.user_name;
        data['view_historey'] = this.view_historey;
        data['view_state_id'] = this.view_state_id;
        data['view_state_name'] = this.view_state_name;
        data['weight'] = this.weight;
        data['with_id'] = this.with_id;
        data['with_name'] = this.with_name;
        data['with_phone'] = this.with_phone;
        data['with_pincode'] = this.with_pincode;
        data['zoon_id'] = this.zoon_id;
        data['zoon_name'] = this.zoon_name;
        return data;
    }
}