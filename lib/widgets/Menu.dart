import 'package:bunnypay007/config/dbconnection.dart';
import 'package:bunnypay007/widgets/Profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'griddashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Menu extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        //backgroundColor: Color(0xffffffff).withOpacity(.90),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 110,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "WELCOME",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Color(0xff511f52),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Home",
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Color(0xffa29aac),
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  IconButton(
                    alignment: Alignment.topCenter,
                    icon: Icon(
                      Icons.person,
                      color: Color(0xc4511f52),
                    ),
                    onPressed: () {
                      GetParent(parentId);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MemberProfilePage()));
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            GridDashboard()
          ],
        ),
      ),
    );
  }
}
GetParent(parentId) async{
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