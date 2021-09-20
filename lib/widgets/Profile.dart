import 'package:bunnypay007/config/dbconnection.dart';
import 'package:bunnypay007/config/palette.dart';
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
String parentFirstName="";
var parentLastName ="";
var parentPhone ="";
var parentEmail="";


final textController_1 = TextEditingController()..text=parentPhone;

TextEditingController fr = TextEditingController()..text = parentFirstName;
TextEditingController ls = TextEditingController()..text = parentLastName;
TextEditingController em = TextEditingController()..text = parentEmail;
TextEditingController pho = TextEditingController()..text = parentPhone;

 Future<dynamic> GetParent() async{
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

  return parse;
}

class MemberProfilePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<MemberProfilePage> {



  @override
  void initState(){

  }


  void _showDialog(BuildContext context, {String title, String msg}) {
    final dialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        RaisedButton(
          color: Color(0xff511f52),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Close',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
    showDialog(context: context, builder: (x) => dialog);
  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:AppBar(
        title: Text("Profile"),
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
      body:FutureBuilder(
        future: GetParent(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.data == null){
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ]
              ),
            );
          }else{
            return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/avatarr.png'),
            ),
            Text(parentFirstName+' '+parentLastName,
                    style: GoogleFonts.pacifico(
                    fontSize: 40,
                    color: Color(0xffb97898),
                    fontWeight: FontWeight.bold)),

            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 12.0,
                ),
                //OutlineButton(
                RaisedButton(
                  color: Color(0xff511f52),
                  onPressed: () async {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => EditProfil()));
                 GetParent();

                  },
                  child: Text("Edit Profile"),
                    textColor: Colors.white,

                  padding:
                  EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
                ),
              ],
            ),
            SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Color(0xff511f52),
              ),
            ),
            InfoCard(

              text:"+216" + parentPhone ,
              icon: Icons.phone,



            ),
            InfoCard(
              text: parentEmail,
              icon: Icons.email,

            ),
          InfoCard(
              text: url,
              icon: Icons.web,
              onPressed: () async {
                if (await launcher.canLaunch(url)) {
                  await launcher.launch(url);
                } else {
                  _showDialog(
                    context,
                    title: 'Sorry',
                    msg: 'URL can not be opened. Please try again!',
                  );
                }
              },
            ),
            InfoCard(
              text: location,
              icon: Icons.location_city,
              onPressed: null,
            ),
          ],
        );
          }
        },
      ),


    );
  }
}

//////////////////////////////////////////////
class EditProfil extends StatefulWidget {
  @override
  _EditProfilState createState() => _EditProfilState();
}

class _EditProfilState extends State<EditProfil> {






  @override
  void initState(){
  GetParent();
  }
  bool showPassword = false;
  var firstname, lastname, phone, email, oldPassword, newPassword, ConfirmpasswordP;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
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
                        controller: fr,

                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Palette.iconColor,
                          ),
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
                        controller: ls,

                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                             prefixIcon: Icon(
                          Icons.person,
                          color: Palette.iconColor,
                        ),
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
                        controller: em,

                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Palette.iconColor,
                          ),
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
                        controller: pho,

                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Palette.iconColor,
                          ),
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
                      UpdateParent(firstname, lastname, email ,parentId,phone,oldPassword,newPassword);
                      setState(() {
                        parentFirstName = firstname;
                        parentLastName = lastname;
                        parentPhone = phone;
                        parentEmail = email;

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

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(

            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}







UpdateParent(firstname, lastname, email ,parentId,phone,oldPassword,newPassword) async{
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
      'firstname': firstname,'lastname':lastname,"email":email,"parentId":parentId,"oldPassword":oldPassword,"newPassword":newPassword,
    }),
  );
  print(response.body);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var parse = jsonDecode(response.body);
print(parse);


}