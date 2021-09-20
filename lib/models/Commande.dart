
import 'Producthistory.dart';

class Commande {
  String id;
  String date;
  String child;
  String childimg;
  String shop;
  int prodtotal;
  int total;


  Commande({this.id,this.date, this.child, this.childimg, this.shop, this.prodtotal, this.total});

  Commande.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    child = json['child'];
    childimg = json['childimg'];
    shop = json['shop'];
    prodtotal = json['prodtotal'];
    total = json['total'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['child'] = this.child;
    data['childimg'] = this.childimg;
    data['shop'] = this.shop;
    data['prodtotal'] = this.prodtotal;
    data['total'] = this.total;

    return data;
  }
}
