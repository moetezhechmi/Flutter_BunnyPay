import 'package:bunnypay007/models/Commande.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'dbconnection.dart';

List<Commande> parseHistory(String responseBody){
  var list = json.decode(responseBody) as List<dynamic>;
  List<Commande> commandes = list.map((model) => Commande.fromJson(model)).toList();
  return commandes ;
}

Future<List<Commande>> getCommande() async{
  SharedPreferences prefs1 = await SharedPreferences.getInstance();
  //Return int
  var parentId = prefs1.getString("idParent");
  final response = await http.post(base_url+'/traders/test',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'parentId': parentId,
    }),
  );
  if(response.statusCode == 200){
    return compute(parseHistory, response.body);
  }
  else{
    throw Exception('Request API Error');
  }
}
