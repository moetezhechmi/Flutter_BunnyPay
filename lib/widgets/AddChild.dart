import 'dart:convert';
import 'dart:io';
import 'package:bunnypay007/config/dbconnection.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Profile.dart';

PickedFile imageURI;
final ImagePicker _picker = ImagePicker();
String state = "";
bool etat = false;
var file;

class PageAddChild extends StatefulWidget {
  @override
  _PageAddChildState createState() => _PageAddChildState();
}

class _PageAddChildState extends State<PageAddChild> {
  final textController_1 = TextEditingController();
  final textController_2 = TextEditingController();
  final textController_3 = TextEditingController();
  String text1, text2, text3;

  var firstname, lastname, age, parentId, sexe, etat;
  String valueChoose;
  List listItem = ["Boy", "Girl"];
  int selectedValue;

  File imageFile;
  int _radioValue = 0;

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2001),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          break;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    selectedValue = 0;
  }

  SetSelectedValue(int val) {
    setState(() {
      selectedValue = val;
    });
  }

  Future getImageFromCameraGallery() async {
    var image = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      imageURI = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Add Child"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xff511f52), Color(0xffb97898)])),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: 50.0, top: 40, right: 50.0, bottom: 10.0),
                ),
                Column(
                  children: [
                    Container(
                      child: imageURI == null
                          ? Image(
                              image: AssetImage(
                                'assets/images/avatarr.png',
                              ),
                              width: 140)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(200.0),
                              child: Image.file(
                                File(imageURI.path),
                                width: 200,
                              )),
                    ),
                    IconButton(
                      alignment: Alignment.topCenter,
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Color(0xc4511f52),
                      ),
                      onPressed: () {
                        getImageFromCameraGallery();
                      },
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 50.0, top: 20, right: 50.0),
                    ),
                    Center(
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
                              labelText: 'FirstName',
                              contentPadding:
                                  EdgeInsets.fromLTRB(30.0, 15.0, 20.0, 20.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                            ),
                            onChanged: (value) {
                              firstname = value;
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(top: 20)),
                    Center(
                      child: Container(
                        width: 400,
                        child: new Theme(
                          data: new ThemeData(
                            primaryColor: Color(0xff511f52),
                            primaryColorDark: Color(0xff511f52),
                          ),
                          child: TextField(
                            controller: textController_2,
                            keyboardType: TextInputType.text,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'LastName',
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
                    Row(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(top: 80, right: 10)),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: IconButton(
                              color: Color(0xc4511f52),
                              icon: Icon(Icons.calendar_today_sharp),
                              onPressed: () {
                                setState(() {
                                  _selectDate(context);
                                });
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            "${selectedDate.toLocal()}".split(' ')[0],
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.only(top: 20)),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      new Radio(
                        value: 0,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      new Text(
                        'Boy',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                      new Radio(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: _handleRadioValueChange,
                      ),
                      new Text(
                        'Girl',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                    ]),
                    Padding(padding: const EdgeInsets.only(top: 20)),
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
                          'Add Child',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 120.0, vertical: 20.0),
                      ),
                      onPressed: () async {
                        GetChildren(parentId);
                        if (_radioValue == 0) {
                          sexe = "Boy";
                        } else {
                          sexe = "Girl";
                        }
                        text1 = textController_1.text;
                        text2 = textController_2.text;
                        if (text1 == '' || text2 == '') {
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
                        } else {
                          var res = await uploadImage(
                              firstname,
                              lastname,
                              "${selectedDate.toLocal()}".split(' ')[0],
                              parentId,
                              sexe,
                              imageURI.path);
                          setState(() {
                            state = res;
                            print(res);
                            imageURI = null;
                          });

                          Alert(
                            context: context,
                            type: AlertType.success,
                            title: "",
                            desc: "Child Added Succefully.",
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
                              DialogButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () => Navigator.pop(context),
                                gradient: LinearGradient(colors: [
                                  Color(0xff511f52),
                                  Color(0xff511f52)
                                ]),
                              )
                            ],
                          ).show();
                        }
                      },
                    ),
                  ],
                )
              ]),
            ],
          ),
        ),
      ),
    );
  }

  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 200,
      maxHeight: 200,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}

Future<String> uploadImage(
    firstname, lastname, age, parentId, sexe, filename) async {
  var url = base_url + "/parents/AddChild";
  var request = http.MultipartRequest('POST', Uri.parse(url));
  SharedPreferences prefs1 = await SharedPreferences.getInstance();
  //Return int
  String parentId = prefs1.getString("idParent");
  request.files.add(await http.MultipartFile.fromPath('file', filename));
  request.fields['firstname'] = firstname;
  request.fields['lastname'] = lastname;
  request.fields['age'] = age;
  request.fields['parentId'] = parentId;
  request.fields['sexe'] = sexe;

  var res = await request.send();
  return res.reasonPhrase;
}

GetChildren(parentId) async {
  var url = base_url + "/parents/getChildsByParent";

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
  print(parse);
}
