

import 'package:bunnypay007/config/dbconnection.dart';
import 'package:bunnypay007/config/palette.dart';
import 'package:bunnypay007/widgets/Authentification.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:rflutter_alert/rflutter_alert.dart';
class ForgotPassword extends StatefulWidget{
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();

}
class _ForgotPasswordState  extends State<ForgotPassword> {
  var message,code,email="";
  sendMailClass s ;
  updatemdpClass u;
  bool isVisible = true ;
  bool show = true ;
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;
  var c1,c2,c3,c4,c5,c6;
  var codefinal,codesended;
  var password,cpassword;
  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    pin5FocusNode = FocusNode();
    pin6FocusNode = FocusNode();
  }
  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    pin5FocusNode.dispose();
    pin6FocusNode.dispose();
    super.dispose();

  }
  void nextField({String value,FocusNode focusNode}){
    if(value.length == 1){
      focusNode.requestFocus();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xffb97898), Color(0xffb97898)])),
        ),
      ),
      body:
      Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 600,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/forgot.png",
                    width: 80,
                  ),
                  SizedBox(height: 15,),
                  Stack(
                    children: <Widget>[
                      // Stroked text as border.
                      Text(
                        'FORGET PASSWORD',
                        style: TextStyle(
                          fontSize: 36,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 6
                            ..color = Color(0xff511f52),
                        ),
                      ),
                      // Solid text as fill.
                      Text(
                        'FORGET PASSWORD',
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Visibility(
                    visible: isVisible,
                    child:
                  Text("Provider your account's email for which you want \n                    to reset your password!",
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                    replacement:
                    Visibility(
                      visible: show,
                        child:
                        Text("We sent your code to "+email),
                      replacement: Text("Know you can change your password"),

                    ),
                  ),
                  SizedBox(height: 60,),
                  Visibility(
                    visible: isVisible,
                    child: Container(
                      width: 320,

                      child:TextField(
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.mail_outline,
                              color: Palette.iconColor,
                            ),

                            contentPadding: EdgeInsets.all(10),
                            hintText: "Enter your email",
                            hintStyle: TextStyle(fontSize: 14,
                                color: Palette.textColor1),
                          ),
                          onChanged: (value) {
                            email=value;
                          },
                        ),

                    ),
                    replacement:
                     Visibility(
                       visible: show,
                       child:
                       Form(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8,right:8),
                         child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          SizedBox(
                           width: 50 ,
                            child: TextFormField(
                              autofocus: true,
                              obscureText: true,
                              style: TextStyle(fontSize: 24),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 15
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (value){
                              nextField(value: value,focusNode: pin2FocusNode);
                              c1=value;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 50 ,
                            child: TextFormField(
                              focusNode: pin2FocusNode,
                              obscureText: true,
                              style: TextStyle(fontSize: 24),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (value){
                                nextField(value: value,focusNode: pin3FocusNode);
                                c2=value;

                              },
                            ),
                          ),
                          SizedBox(
                            width: 50 ,
                            child: TextFormField(
                              focusNode: pin3FocusNode,
                              obscureText: true,
                              style: TextStyle(fontSize: 24),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (value){
                                nextField(value: value,focusNode: pin4FocusNode);
                                c3=value;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 50 ,
                            child: TextFormField(
                              focusNode: pin4FocusNode,
                              obscureText: true,
                              style: TextStyle(fontSize: 24),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (value){
                                nextField(value: value,focusNode: pin5FocusNode);
                                c4=value;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 50 ,
                            child: TextFormField(
                              focusNode: pin5FocusNode,
                              obscureText: true,
                              style: TextStyle(fontSize: 24),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (value){
                                nextField(value: value,focusNode: pin6FocusNode);
                                c5=value;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 50 ,
                            child: TextFormField(
                              focusNode: pin6FocusNode,
                              obscureText: true,
                              style: TextStyle(fontSize: 24),
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                              onChanged: (value){
                                pin6FocusNode.unfocus();
                                c6=value;

                              },
                            ),
                          )
                        ],
                    ),
                  ),

                  ),
                       replacement:

                       Column(
                         children: [
                           Container(
                             width: 320,

                             child:TextField(
                               obscureText: true,
                               keyboardType: TextInputType.text,
                               decoration: InputDecoration(
                                 prefixIcon: Icon(
                                   Icons.lock_outlined,
                                   color: Palette.iconColor,
                                 ),

                                 contentPadding: EdgeInsets.all(10),
                                 hintText: "New Password",
                                 hintStyle: TextStyle(fontSize: 14,
                                     color: Palette.textColor1),
                               ),
                               onChanged: (value) {
                                password = value;
                               },
                             ),

                           ),
                           SizedBox(width: 7,),
                           Container(
                             width: 320,

                             child:TextField(
                               obscureText: true,
                               keyboardType: TextInputType.text,
                               decoration: InputDecoration(
                                 prefixIcon: Icon(
                                   Icons.lock_outlined,
                                   color: Palette.iconColor,
                                 ),

                                 contentPadding: EdgeInsets.all(10),
                                 hintText: "Confirm Password",
                                 hintStyle: TextStyle(fontSize: 14,
                                     color: Palette.textColor1),
                               ),
                               onChanged: (value) {
                                 cpassword=value;

                               },
                             ),

                           ),
                         ],
                       ),
                     ),
                  ),
                  SizedBox(height: 15,),
                  Visibility(
                    visible: isVisible,
                    child: Container(
                        width: 320,

                        child: ElevatedButton(
                            onPressed: ()  async {

                              setState(() {
                                isVisible = !isVisible;
                              });
                               s =  await sendMail(email);

                                   print(s.code);

                                   if(s.message =="mail sent successfully"){
                                    codesended = s.code;
                                   }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffb97898),


                            ),
                            child: Text(' Send'))
                    ),
                    replacement:
                    Visibility(
                      visible: show,
                      child: Container(
                          width: 320,
                          child: ElevatedButton(
                              onPressed: () async{

                                codefinal=c1+c2+c3+c4+c5+c6;
                                print(codefinal);
                                if(codefinal == codesended){

                                  setState(() {
                                    show = false;
                                  });

                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xffb97898),


                              ),
                              child: Text('Done'))
                      ),
                      replacement:
                      Container(
                        width: 320,
                        child: ElevatedButton(
                            onPressed: () async{
                                print("finish");
                                if(password==cpassword){
                                  u=await updatemdp(email,password);
                                  if(u.message=="Update password successfully"){
                                    Alert(
                                      context: context,
                                      title: "",
                                      desc: "Your password was updated successfully",
                                      image: Image.asset("assets/images/tick.png",width: 70,height: 70,),
                                    ).show();
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Authentification()));
                                  }

                                }
                                else{
                                  Alert(
                                    type: AlertType.warning,
                                    context: context,
                                    title: "",
                                    desc: "Passwords not matched",
                                    buttons: [

                                      DialogButton(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 20),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        gradient: LinearGradient(colors: [
                                          Color(0xffb97898),
                                          Color(0xffb97898)
                                        ]),
                                      )
                                    ],

                                  ).show();
                                }

                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffb97898),
                            ),
                            child: Text('Finish'))
                    ),
                    ),
                  ),
                ],

              ),
            ),
          ),
        ],


      )

    );

  }






}



Future<sendMailClass> sendMail(email) async {
  var url = base_url+"/parents/sendmail";
  String message,code;
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "email":email,
    }),
  );
  var parse = jsonDecode(response.body);
  message = parse["message"];
  code = parse["code"];
  return sendMailClass(code: code,message: message);

}
Future<updatemdpClass> updatemdp(email,password) async {
  var url = base_url+"/parents/updatemdp";
  String message;
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "email":email,"password":password,
    }),
  );
  var parse = jsonDecode(response.body);
  message = parse["message"];

  return updatemdpClass(message: message);

}

class sendMailClass {
  final String message;
  final String code;
  sendMailClass({this.message, this.code});
}
class updatemdpClass{
  final String message;
  updatemdpClass({this.message});



}