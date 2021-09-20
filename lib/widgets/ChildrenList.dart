import 'dart:async';
import 'dart:convert';
import 'package:bunnypay007/config/dbconnection.dart';
import 'package:bunnypay007/config/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String firstname;
String lastname;
String sexe;
String solde;
String accepted;

String parentId;
String childId;
String age;
String variable;
var parse;
void main() {
  runApp(new MaterialApp(home: new HomePage()));
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List data;

  GetChildren(parentId) async {
    var url = base_url + "/parents/getChildsByParent";

    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    //Return int
    parentId = prefs1.getString("idParent");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'parentId': parentId,
      }),
    );
    print(response.body);

    this.setState(() {
      data = json.decode(response.body);
    });
    parse = jsonDecode(response.body);
    childId = parse["_id"];
    firstname = parse["firstname"];
    lastname = parse["lastname"];
    sexe = parse["sexe"];
    age = parse["age"];
    solde = parse["solde"];
    accepted = parse["accepted"];
  }

  DeleteChildren(parentId, childId) async {
    var url = base_url + "/parents/deleteChild";

    SharedPreferences prefs1 = await SharedPreferences.getInstance();

    //Return int
    parentId = prefs1.getString("idParent");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'parentId': parentId, 'childId': variable}),
    );
    print(response.body);
    data = json.decode(response.body);
  }

  Lost(parentId, childId) async {
    var url = base_url + "/parents/Lost";

    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    //Return int
    parentId = prefs1.getString("idParent");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'parentId': parentId, 'childId': variable}),
    );
    print(response.body);
    data = json.decode(response.body);
  }

  static final double radius = 20;

  UniqueKey keyTile;
  bool isExpanded = false;

  void expandTile() {
    setState(() {
      isExpanded = true;
      keyTile = UniqueKey();
    });
  }

  void shrinkTile() {
    setState(() {
      isExpanded = false;
      keyTile = UniqueKey();
    });
  }

  @override
  void initState() {
    GetChildren(parentId);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("List Children"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xff511f52), Color(0xffb97898)])),
        ),
      ),
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: Padding(
            padding: EdgeInsets.all(12),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: BorderSide(color: Colors.black, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => isExpanded ? shrinkTile() : expandTile(),
                        child: buildImage(index),
                      ),
                      buildText(context, index),
                    ],
                  ),
                ),
              ),
            ),
          ));
        },
      ),
    );
  }

  Widget buildImage(index) => Image(
        image: NetworkImage(base_url_image + data[index]["photo"]),
        fit: BoxFit.cover,
        width: double.infinity,
        height: 400,
      );

  Widget buildText(BuildContext context, index) => Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          key: keyTile,
          initiallyExpanded: isExpanded,
          childrenPadding: EdgeInsets.all(16).copyWith(top: 0),
          title: Text(
            data[index]["firstname"] + " " + data[index]["lastname"],
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 100),
              child: Text(
                "Age: " + " " + data[index]["age"] + " " + "years old",
                style: TextStyle(
                    fontSize: 18, height: 1.4, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 130, top: 20),
              child: Text(
                "Solde: " + " " + data[index]["solde"] + " " + "DT",
                style: TextStyle(
                    fontSize: 18, height: 1.4, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 188, top: 20),
              child: Text(
                "Etat: " + " " + data[index]["accepted"],
                style: TextStyle(
                    fontSize: 18,
                    height: 1.4,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffb97898)),
              ),
            ),
            Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 1, left: 10, top: 20),
                    child: data[index]["accepted"]=="Accepted" ?  RaisedButton(
                      onPressed: () {
                        variable = data[index]["_id"];
                        print(variable);
                        Lost(parentId, variable);
                        Alert(
                          context: context,
                          type: AlertType.success,
                          title: "",
                          desc: "We will solve your problem soon",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Ok",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              color: Color(0xffb97898),
                            ),
                          ],
                        ).show();
                      },
                      color: Color(0xff711517),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Mark as Lost",
                        style: TextStyle(
                            fontSize: 12, color: Colors.white),
                      ),
                    ):Text("")
                ),
                SizedBox(width: 90,),
                Padding(
                    padding: const EdgeInsets.only( top: 20),
                    child:  RaisedButton(
                      onPressed: () {
                        variable = data[index]["_id"];
                        print(variable);
                        DeleteChildren(parentId, variable);
                        Alert(
                          context: context,
                          type: AlertType.success,
                          title: "",
                          desc: "We will solve your problem soon",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Ok",
                                style: TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              color: Color(0xffb97898),
                            ),
                          ],
                        ).show();
                      },
                      color: Color(0xffa53033),
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "Delete Child",
                        style: TextStyle(
                            fontSize: 12, color: Colors.white),
                      ),
                    )
                ),
              ],
            ),
          ],
        ),
      );
}
