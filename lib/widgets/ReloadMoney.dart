import 'dart:convert';

import 'package:bunnypay007/config/dbconnection.dart';
import 'package:bunnypay007/config/palette.dart';
import 'package:bunnypay007/models/Child.dart';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
String firstname;
String lastname;
String sexe;
String parentId;
String childId;
String id ;
var idC;
String age;
String variable;
String code;
var parse;
class ReloadMoney extends StatefulWidget {
  @override
  _PageReloadMoneyState createState() => _PageReloadMoneyState();
}

class _PageReloadMoneyState extends State<ReloadMoney> {
  String dropdownValue = 'One';
  final textController_1 = TextEditingController();
  String text1;
  List data=List();
String selectedValue;

  GetChildren(parentId) async{
    var url = base_url+"/parents/getDropdownChild";

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
    id = parse["_id"];
    firstname = parse["firstname"];
    lastname = parse["lastname"];
    sexe = parse["sexe"];
    age = parse["age"];
  }


  getChildbyName(parentId,firstname) async{
    var url = base_url+"/parents/getChildByName";

    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    //Return int
    parentId = prefs1.getString("idParent");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'parentId': parentId,'firstname':firstname
      }),
    );



    parse = jsonDecode(response.body);
    print(response.body);
    idC=parse;

  }

  ReloadMoney(code) async {
    var url = base_url+"/parents/reloadMoney";

    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    //Return int

    String parentId = prefs1.getString("idParent");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'traderId': '605b0f454a1d320a5b39afa1',
        'parentId': parentId,
        "childId": idC,
        "code":code

      }),
    );
    print(idC);





  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChildbyName(parentId, selectedValue);
    GetChildren(parentId);


  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Reload Money"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xff511f52),
                    Color(0xffb97898)
                  ])
          ),
        ),
      ),
      body: Container(

        child:SingleChildScrollView(
          child:Column(
            children: [
              Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left:50.0, top:80,right:50.0,bottom:10.0),

                ),

                Column(

                  children: [
                    Image(image: AssetImage('assets/images/pochette.gif',),width: 400),


                    Padding(
                      padding: EdgeInsets.only(left:50.0, top:20,right:50.0),

                    ),
                    Center(
                      child: Container(
                        width: 300,

                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text('select child'),
                          value: selectedValue,
                          items: data.map((Child){

                            return DropdownMenuItem(
                                value: Child['firstname'],
                                child: Text(Child['firstname']));


                          }).toList(),
                          onChanged: (value){
                            setState(() {

                              selectedValue=value;
                              getChildbyName(parentId, selectedValue);
                            });
                          },
                        )
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only( top: 20)),
                    Center(
                      child: Container(
                        width: 300,
                        child: TextField(
                          controller: textController_1,
                          keyboardType: TextInputType.number,

                          obscureText: false,

                          decoration: InputDecoration(

                            labelText: 'Card number',
                            prefixIcon: Icon(
                              Icons.money,
                              color: Palette.iconColor,
                            ),
                            contentPadding: EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 20.0),
                            border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),



                          ),
                          onChanged: (value){
                            code=value;
                          },

                        ),
                      ),
                    ),





SizedBox(height: 30,),
                    Padding(
                        padding: const EdgeInsets.only( top: 20)),


                    RaisedButton(
                      textColor: Colors.white,
                      padding: EdgeInsets.all(0.0),
                      shape: StadiumBorder(),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xff511f52),
                              Color(0xffe8b7d4),
                            ],
                          ),
                        ),
                        child: Text(
                          'Pay',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 120.0, vertical: 20.0),
                      ),
                      onPressed: () {
                        text1 = textController_1.text;
                        if(text1 == ''){
                          Alert(
                            context: context,
                            type: AlertType.warning,
                            title: "",
                            desc: "Fields must not be empty.",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Ok",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                color: Color(0xffb97898),
                              ),

                            ],
                          ).show();
                        }
                        else {
                          getChildbyName(parentId, selectedValue);
                          ReloadMoney(code);


                          Alert(
                            context: context,
                            type: AlertType.success,
                            title: "",
                            desc: "Recharge Done",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Ok",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),

                                color: Color(0xffb97898),
                              ),
                              DialogButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                gradient: LinearGradient(colors: [
                                  Color(0xff511f52),  Color(0xff511f52)
                                ]),
                              )
                            ],
                          ).show();
                        }

                      },
                    ),


                    Image.asset("assets/images/visa.png", width: 200,
                    ),

                  ],
                )




              ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}





