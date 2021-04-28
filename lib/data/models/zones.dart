class ZoneModel {
    bool activeStaet;
    int driverCode;
    String driverName;
    int id;
    int provinceCode;
    String prvovinceName;
    int zoonCost;
    int zoonId;
    String zoonName;
    int zoonPrice;

    ZoneModel({this.activeStaet,  this.driverCode, this.driverName, this.id, this.provinceCode, this.prvovinceName, this.zoonCost, this.zoonId, this.zoonName, this.zoonPrice});

    factory ZoneModel.fromJson(Map<String, dynamic> json) {
        return ZoneModel(
            activeStaet: json['activeStaet'],
            driverCode: json['driverCode'],
            driverName: json['driverName'],
            id: json['id'],
            provinceCode: json['provinceCode'],
            prvovinceName: json['prvovinceName'],
            zoonCost: json['zoonCost'],
            zoonId: json['zoonId'],
            zoonName: json['zoonName'],
            zoonPrice: json['zoonPrice'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['activeStaet'] = this.activeStaet;
        data['driverCode'] = this.driverCode;
        data['driverName'] = this.driverName;
        data['id'] = this.id;
        data['provinceCode'] = this.provinceCode;
        data['prvovinceName'] = this.prvovinceName;
        data['zoonCost'] = this.zoonCost;
        data['zoonId'] = this.zoonId;
        data['zoonName'] = this.zoonName;
        data['zoonPrice'] = this.zoonPrice;
        return data;
    }
}