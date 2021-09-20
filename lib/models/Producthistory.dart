class Producthistory {
  String sId;
  String quantite;
  String prod;

  Producthistory({this.sId, this.quantite, this.prod});

  Producthistory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quantite = json['quantite'];
    prod = json['prod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['quantite'] = this.quantite;
    data['prod'] = this.prod;
    return data;
  }
}
