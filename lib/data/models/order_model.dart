class OrderResponse {
    List<Order> data;
    String message;
    int status;

    OrderResponse({this.data, this.message, this.status});

    factory OrderResponse.fromJson(Map<String, dynamic> json) {
        var extractingJson  ;
        try{ extractingJson = json['data']['data'] ; } catch(Exception){ extractingJson = json['data'] ; }
        return OrderResponse(
            data: extractingJson != null ? (extractingJson as List).map((i) => Order.fromJson(i)).toList() : null,
            message: "${json['message']}",
            status: int.parse("${json['status']??0}"),
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

class Order {
    int accountId;

    String accountPincode;
    bool activeDel;

    int additionalCostShipping;
    int additionalPriceGoods;
    int additionalPriceShipping;

    String adressResiver;

    int boxClient;
    int boxDriver;
    int branchId;

    String branchName;
    bool checkDoubel;
    bool checkGood;
    bool checkLate;
    bool checkPrice;

    int costShipping;

    String date;
    String dateProcess;

    int deleverClient;
    int deleverDriver;
    int goodsNew;
    int id;

    String phoneResiver;

    int priceGoods;
    int priceNew;
    int priceShipping;

    String provinceName;

    int proviniceId;
    int qty;

    String resiverName;
    String shipingNr;
    String stateCleint;

    int stateDeleiverId;

    String stateDeliverName;
    String stateDriver;
    String timeProcess;

    int totalCost;
    int totalCostShipping;
    int totalPrice;
    int totalPriceClient;
    int totalPriceShipping;
    int totalProphet;
    int typeGoods;
    int weight;
    int withId;

    String withName;
    String withPhone;
    String withPincode;

    int zoonId;

    String zoonName;

    Order({this.accountId, this.accountPincode, this.activeDel, this.additionalCostShipping, this.additionalPriceGoods, this.additionalPriceShipping, this.adressResiver, this.boxClient, this.boxDriver, this.branchId, this.branchName, this.checkDoubel, this.checkGood, this.checkLate, this.checkPrice, this.costShipping, this.date, this.dateProcess, this.deleverClient, this.deleverDriver, this.goodsNew, this.id, this.phoneResiver, this.priceGoods, this.priceNew, this.priceShipping, this.provinceName, this.proviniceId, this.qty, this.resiverName, this.shipingNr, this.stateCleint, this.stateDeleiverId, this.stateDeliverName, this.stateDriver, this.timeProcess, this.totalCost, this.totalCostShipping, this.totalPrice, this.totalPriceClient, this.totalPriceShipping, this.totalProphet, this.typeGoods, this.weight, this.withId, this.withName, this.withPhone, this.withPincode, this.zoonId, this.zoonName});

    factory Order.fromJson(Map<String, dynamic> json) {
        return Order(
            accountId:int.parse("${ json['accountId']??0}"),

            accountPincode: "${json['accountPincode']}",
            activeDel: json['activeDel'],

            additionalCostShipping:int.parse("${ json['additionalCostShipping']??0}"),
            additionalPriceGoods: int.parse("${json['additionalPriceGoods']??0}"),
            additionalPriceShipping: int.parse("${json['additionalPriceShipping']??0}"),

            adressResiver: "${json['adressResiver']}",

            boxClient: int.parse("${json['boxClient']??0}"),
            boxDriver:int.parse("${ json['boxDriver']??0}"),
            branchId: int.parse("${json['branchId']??0}"),

            branchName: "${json['branchName']}",
            checkDoubel: json['checkDoubel'],
            checkGood: json['checkGood'], 
            checkLate: json['checkLate'], 
            checkPrice: json['checkPrice'],

            costShipping: int.parse("${json['costShipping']??0}"),

            date: "${json['date']}",
            dateProcess: "${json['dateProcess']}",

            deleverClient:int.parse("${ json['deleverClient']??0}"),
            deleverDriver: int.parse("${json['deleverDriver']??0}"),
            goodsNew: int.parse("${json['goodsNew']??0}"),
            id: int.parse("${json['id']??0}"),

            phoneResiver: "${json['phoneResiver']}",

            priceGoods: int.parse("${json['priceGoods']??0}"),
            priceNew: int.parse("${json['priceNew']??0}"),
            priceShipping: int.parse("${json['priceShipping']??0}"),

            provinceName: "${json['provinceName']}",

            proviniceId: int.parse("${json['proviniceId']??0}"),
            qty: int.parse("${json['qty']??0}"),

            resiverName: "${json['resiverName']}",
            shipingNr:"${ json['shipingNr']}",
            stateCleint:"${ json['stateCleint']}",

            stateDeleiverId: int.parse("${json['stateDeleiverId']??0}"),

            stateDeliverName: "${json['stateDeliverName']}",
            stateDriver: "${json['stateDriver']}",
            timeProcess: "${json['timeProcess']}",

            totalCost: int.parse("${json['totalCost'] ?? 0}"),
            totalCostShipping: int.parse("${json['totalCostShipping']??0}"),
            totalPrice: int.parse("${json['totalPrice']??0}"),
            totalPriceClient:int.parse("${ json['totalPriceClient']??0}"),
            totalPriceShipping: int.parse("${json['totalPriceShipping']??0}"),
            totalProphet: int.parse("${json['totalProphet']??0}"),
            typeGoods: int.parse("${json['typeGoods']??0}"),
            weight: int.parse("${json['weight']??0}"),
            withId:int.parse("${json['weight']??0}"),

            withName: "${json['withName']}",
            withPhone:"${ json['withPhone']}",
            withPincode: "${json['withPincode']}",
            zoonId: int.parse("${json['zoonId']??0}"),
            zoonName: "${json['zoonName']}",
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['accountId'] = this.accountId;
        data['accountPincode'] = this.accountPincode;
        data['activeDel'] = this.activeDel;
        data['additionalCostShipping'] = this.additionalCostShipping;
        data['additionalPriceGoods'] = this.additionalPriceGoods;
        data['additionalPriceShipping'] = this.additionalPriceShipping;
        data['adressResiver'] = this.adressResiver;
        data['boxClient'] = this.boxClient;
        data['boxDriver'] = this.boxDriver;
        data['branchId'] = this.branchId;
        data['branchName'] = this.branchName;
        data['checkDoubel'] = this.checkDoubel;
        data['checkGood'] = this.checkGood;
        data['checkLate'] = this.checkLate;
        data['checkPrice'] = this.checkPrice;
        data['costShipping'] = this.costShipping;
        data['date'] = this.date;
        data['dateProcess'] = this.dateProcess;
        data['deleverClient'] = this.deleverClient;
        data['deleverDriver'] = this.deleverDriver;
        data['goodsNew'] = this.goodsNew;
        data['id'] = this.id;
        data['phoneResiver'] = this.phoneResiver;
        data['priceGoods'] = this.priceGoods;
        data['priceNew'] = this.priceNew;
        data['priceShipping'] = this.priceShipping;
        data['provinceName'] = this.provinceName;
        data['proviniceId'] = this.proviniceId;
        data['qty'] = this.qty;
        data['resiverName'] = this.resiverName;
        data['shipingNr'] = this.shipingNr;
        data['stateCleint'] = this.stateCleint;
        data['stateDeleiverId'] = this.stateDeleiverId;
        data['stateDeliverName'] = this.stateDeliverName;
        data['stateDriver'] = this.stateDriver;
        data['timeProcess'] = this.timeProcess;
        data['totalCost'] = this.totalCost;
        data['totalCostShipping'] = this.totalCostShipping;
        data['totalPrice'] = this.totalPrice;
        data['totalPriceClient'] = this.totalPriceClient;
        data['totalPriceShipping'] = this.totalPriceShipping;
        data['totalProphet'] = this.totalProphet;
        data['typeGoods'] = this.typeGoods;
        data['weight'] = this.weight;
        data['withId'] = this.withId;
        data['withName'] = this.withName;
        data['withPhone'] = this.withPhone;
        data['withPincode'] = this.withPincode;
        data['zoonId'] = this.zoonId;
        data['zoonName'] = this.zoonName;
        return data;
    }
}