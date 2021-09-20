
import 'package:bunnypay007/config/dbconnection.dart';
import 'package:bunnypay007/models/info_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


const url = 'http://bunnypay.com';

const location = 'Tunis, Tunisia';
var parentId;
String parentFirstName;
String parentLastName;
String parentPhone;
String parentEmail;


final textController_1 = TextEditingController()..text=parentPhone;

TextEditingController Fame = TextEditingController()..text = parentFirstName;
TextEditingController Lname = TextEditingController()..text = parentLastName;
TextEditingController Em = TextEditingController()..text = parentEmail;
TextEditingController ph = TextEditingController()..text = parentPhone;
class Modifier extends StatefulWidget {
  @override
  _EditProfilState createState() => _EditProfilState();
}

class _EditProfilState extends State<Modifier> {
  bool showPassword = false;
  var firstname, lastname, phone, email, oldPassword, newPassword,
      ConfirmpasswordP;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),

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
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [

              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/avatarr.png'),
                    ),

                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++textfieldsEdit+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Center(
                  child: Container(
                    width: 400,
                    child: new Theme(
                      data: new ThemeData(
                        primaryColor: Color(0xff511f52),
                        primaryColorDark: Color(0xff511f52),

                      ),
                      child: TextField(
                        controller: Fame,

                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: "Firstname",

                          contentPadding:
                          EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),

                          ),
                        ),
                        onChanged: (value) {
                          firstname = value;
                        },
                      ),
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: Center(
                  child: Container(
                    width: 400,
                    child: new Theme(
                      data: new ThemeData(
                        primaryColor: Color(0xff511f52),
                        primaryColorDark: Color(0xff511f52),

                      ),
                      child: TextField(
                        controller: textController_1,

                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: "Lastname",
                          contentPadding:
                          EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),

                          ),
                        ),
                        onChanged: (value) {
                          lastname = value;
                        },
                      ),
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: Center(
                  child: Container(
                    width: 400,
                    child: new Theme(
                      data: new ThemeData(
                        primaryColor: Color(0xff511f52),
                        primaryColorDark: Color(0xff511f52),

                      ),
                      child: TextField(
                        controller: Em,

                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: "Email",

                          contentPadding:
                          EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),

                          ),
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: Center(
                  child: Container(
                    width: 400,
                    child: new Theme(
                      data: new ThemeData(
                        primaryColor: Color(0xff511f52),
                        primaryColorDark: Color(0xff511f52),

                      ),
                      child: TextField(

                        controller: ph,

                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: "Phone",

                          contentPadding:
                          EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),

                          ),
                        ),
                        onChanged: (value) {
                          phone = value;
                        },
                      ),
                    ),
                  ),
                ),
              ),


              //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++End


              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      UpdateParent(
                          firstname,
                          lastname,
                          email,
                          parentId,
                          phone,
                          oldPassword,
                          newPassword);
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                    color: Color(0xff511f52),
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  UpdateParent(firstname, lastname, email, parentId, phone, oldPassword,
      newPassword) async {
    var url = base_url+"/parents/updateParent";

    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    //Return int
    String parentId = prefs1.getString("idParent");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'firstname': firstname,
        'lastname': lastname,
        "email": email,
        "parentId": parentId,
        "oldPassword": oldPassword,
        "newPassword": newPassword,
      }),
    );
    print(response.body);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var parse = jsonDecode(response.body);
    print(parse);
  }


  Future<String> GetParent(parentId) async{
    var url = base_url+"/parents/getParentById";

    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    //Return int
    String parentId = prefs1.getString("idParent");
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


    var parse = jsonDecode(response.body);

    parentFirstName = parse["firstname"];
    parentLastName = parse["lastname"];
    parentPhone = parse["phone"];
    parentEmail = parse["email"];


    print(parentEmail);

    print(parentFirstName);


  }

}