import 'dart:convert';



import 'package:bunnypay007/config/dbconnection.dart';
import 'package:bunnypay007/config/palette.dart';
import 'package:bunnypay007/widgets/ForgotPassword.dart';
import 'package:bunnypay007/widgets/Menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentification extends StatefulWidget{
  @override
  _AuthentificationState createState() => _AuthentificationState();

}

class _AuthentificationState extends State<Authentification> {
  bool isSignupScreen = true;
  bool isRememberMe = false;
  var firstname, lastname, phone, email, password, emailin, passwordin;
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();



  String text1,text2,text3,text4,text5 ;
  String text6,text7;
  var test;
  var response;
  sendMailClassAuth sendm;
  verifiedClass v;
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  FocusNode pin5FocusNode;
  FocusNode pin6FocusNode;
  var c1,c2,c3,c4,c5,c6;
  var codefinal,codesended;

  //bool isMale = true;
  bool showShadow = false;

  _AuthentificationState();
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
    return MaterialApp(
      home: Scaffold(


        backgroundColor: Palette.backgroundColor,
        body: Stack(
          children: [
            //positionned e taswira
            Positioned(
                top: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/image1.jpg"),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 90, left: 20),
                    color: Color(0xffb97898).withOpacity(.60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: "Welcome ",
                                style: TextStyle(
                                  fontSize: 25,
                                  letterSpacing: 2,
                                  color: Color(0xff511f52),
                                ),
                                children: [
                                  TextSpan(
                                    text: isSignupScreen
                                        ? "to BunnyPay,"
                                        : "Back,",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff511f52),
                                    ),)
                                ]
                            )

                        ),
                        SizedBox(height: 5,),
                        Text(
                          isSignupScreen
                              ? "Signup to Continue"
                              : "Signin to Continue",
                          style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )

            ),

            //Main Container for login and signup
            AnimatedPositioned(
                duration: Duration(milliseconds: 800),
                curve: Curves.bounceInOut,
                top: isSignupScreen ? 200 : 230,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  curve: Curves.bounceInOut,
                  height: isSignupScreen ? 530 : 270,
                  padding: EdgeInsets.all(20),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 40,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 15,
                            spreadRadius: 5
                        ),
                      ]
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = false;
                                });
                              },
                              child: Column(
                                children: [
                                  Text("LOGIN",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: !isSignupScreen ? Palette
                                            .activeColor : Palette.textColor2),
                                  ),
                                  if(!isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: Color(0xffb97898)
                                      ,
                                    )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignupScreen = true;
                                });
                              },
                              child: Column(
                                children: [
                                  Text("SIGNUP",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: isSignupScreen ? Palette
                                            .activeColor : Palette.textColor1),
                                  ),
                                  if(isSignupScreen)
                                    Container(
                                      margin: EdgeInsets.only(top: 3),
                                      height: 2,
                                      width: 55,
                                      color: Color(0xffb97898),
                                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                        if(!isSignupScreen) Container(
                          margin: EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: TextField(
                                  controller: emailLoginController,
                                  obscureText: false,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.mail_outline,
                                      color: Palette.iconColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Palette.textColor1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(35.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Palette.textColor1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(35.0)),
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "info@gmail.com",
                                    hintStyle: TextStyle(fontSize: 14,
                                        color: Palette.textColor1),
                                  ),
                                  onChanged: (value) {
                                    emailin = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: TextField(
                                  controller: passwordLoginController,
                                  obscureText: true,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      MaterialCommunityIcons.lock_outline,
                                      color: Palette.iconColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Palette.textColor1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(35.0)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Palette.textColor1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(35.0)),
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "**********",
                                    hintStyle: TextStyle(fontSize: 14,
                                        color: Palette.textColor1),
                                  ),
                                  onChanged: (value) {
                                    passwordin = value;
                                  },
                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(value: isRememberMe,
                                        activeColor: Palette.textColor2,
                                        onChanged: (value) {
                                          setState(() {
                                            isRememberMe = !isRememberMe;
                                          });
                                        },
                                      ),
                                      Text("Remember me",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Palette.textColor1))
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForgotPassword()));
                                    },
                                    child: Text(
                                        "Forgot Password?", style: TextStyle(
                                        fontSize: 12,
                                        color: Palette.textColor1)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        if(isSignupScreen)
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(

                                      decoration: BoxDecoration(
                                        //couleur background signup
                                          color: Color(0xFFFFFFFF)
                                      ),
                                      child: Column(

                                          children: [

                                            Container(

                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .only(bottom: 8.0),
                                                  child: TextField(
                                                    controller: firstnameController,
                                                    decoration: InputDecoration(

                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Palette
                                                                .textColor1),
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                35.0)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Palette
                                                                .textColor1),
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                35.0)),
                                                      ),
                                                      contentPadding: EdgeInsets
                                                          .all(10),
                                                      hintText: "FirstName",

                                                      hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          color: Palette
                                                              .textColor1),

                                                    ),
                                                    onChanged: (value) {
                                                      firstname = value;
                                                    },
                                                  ),
                                                )),
                                            SizedBox(height: 7,),

                                            Container(

                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .only(bottom: 8.0),
                                                  child: TextField(
                                                    controller: lastnameController,
                                                    decoration: InputDecoration(

                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Palette
                                                                .textColor1),
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                35.0)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Palette
                                                                .textColor1),
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                35.0)),
                                                      ),
                                                      contentPadding: EdgeInsets
                                                          .all(10),
                                                      hintText: "LastName",
                                                      hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          color: Palette
                                                              .textColor1),
                                                    ),
                                                    onChanged: (value) {
                                                      lastname = value;
                                                    },
                                                  ),
                                                )),
                                            SizedBox(height: 7,),

                                            Container(

                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .only(bottom: 8.0),
                                                  child: TextField(
                                                    controller: phoneController,
                                                    keyboardType: TextInputType.phone,
                                                    decoration: InputDecoration(

                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Palette
                                                                .textColor1),
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                35.0)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Palette
                                                                .textColor1),
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                35.0)),
                                                      ),
                                                      contentPadding: EdgeInsets
                                                          .all(10),
                                                      hintText: "Phone Number",
                                                      hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          color: Palette
                                                              .textColor1),
                                                    ),
                                                    onChanged: (value) {
                                                      phone = value;
                                                    },
                                                  ),
                                                )),
                                            SizedBox(height: 7,),

                                            Container(

                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .only(bottom: 8.0),
                                                  child: TextField(
                                                    controller: emailController,
                                                    keyboardType: TextInputType.emailAddress,
                                                    decoration: InputDecoration(

                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Palette
                                                                .textColor1),
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                35.0)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Palette
                                                                .textColor1),
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                35.0)),
                                                      ),
                                                      contentPadding: EdgeInsets
                                                          .all(10),
                                                      hintText: "Email",
                                                      hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          color: Palette
                                                              .textColor1),
                                                    ),
                                                    onChanged: (value) {
                                                      email = value;
                                                    },
                                                  ),
                                                )),
                                            SizedBox(height: 7,),

                                            Container(

                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .only(bottom: 8.0),
                                                  child: TextField(
                                                    controller: passwordController,
                                                    obscureText: true,
                                                    decoration: InputDecoration(

                                                      enabledBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Palette
                                                                .textColor1),
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                35.0)),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Palette
                                                                .textColor1),
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                35.0)),
                                                      ),
                                                      contentPadding: EdgeInsets
                                                          .all(10),
                                                      hintText: "Password",
                                                      hintStyle: TextStyle(
                                                          fontSize: 14,
                                                          color: Palette
                                                              .textColor1),
                                                    ),
                                                    onChanged: (value) {
                                                      password = value;
                                                    },
                                                  ),
                                                )),
                                          ]

                                      )
                                  ),

                                  Container(
                                    width: 200,
                                    margin: EdgeInsets.only(top: 20),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          text: "By pressing 'Submit' you agree to our ",
                                          style: TextStyle(
                                              color: Palette.textColor2),
                                          children: [
                                            TextSpan(
                                              text: "term & conditions",
                                              style: TextStyle(
                                                  color: Color(0xffb97898)),
                                            ),
                                          ]
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),

                      ],
                    ),
                  ),
                )
            ),
            //Submit Button SignIn
            AnimatedPositioned(
                duration: Duration(milliseconds: 800),
                curve: Curves.bounceInOut,
                top: isSignupScreen ? 670 : 450,
                right: 0,
                left: 0,
                child: Center(
                  child: Container(
                    height: 90,
                    width: 90,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          if(showShadow)
                            BoxShadow(
                                color: Colors.black.withOpacity(.3),
                                spreadRadius: 1.5,
                                blurRadius: 10,
                                offset: Offset(0, 1)
                            )
                        ]
                    ),
                    child: !showShadow ? Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Color(0xff511f52), Color(0xffb97898)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.3),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1)
                            )
                          ]
                      ),

                      child:
                      //Icon(Icons.arrow_forward,color: Colors.white,),
                      IconButton(
                        icon: new Icon(Icons.arrow_forward),
                        color: Colors.white,

                        onPressed: () async{
                          if (isSignupScreen) {
                            text1=firstnameController.text;
                            text2=lastnameController.text;
                            text3=phoneController.text;
                            text4=emailController.text;
                            text5=passwordController.text;


                            //print(firstname + lastname + phone + email + password);
                            if(text1 == '' || text2 == '' || text3 == '' || text4 == '' || text5 == '' )  {
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "",
                                desc: "Fields must not be empty.",
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
                            else {
                              signUp(firstname, lastname, phone, email, password);

                                sendm=await sendMailAuth(email);


                              print(email);
                              //print(sendm.code);
                              Alert(
                                  context: context,
                                  title: "Verify Your Account",

                                  content: Form(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8,right:8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 40 ,
                                            height: 50,
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
                                            width: 40 ,
                                            height: 50,
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
                                            width: 40 ,
                                            height: 50,
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
                                            width: 40 ,
                                            height: 50,
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
                                            width: 40 ,
                                            height: 50,
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
                                            width: 40 ,
                                            height: 50,
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
                                  buttons: [
                                    DialogButton(

                                      onPressed: () async{
                                        codefinal=c1+c2+c3+c4+c5+c6;
                                        print(codefinal);
                                        print(sendm.code);
                                        if(codefinal == sendm.code){
                                          print("yopiiiiiii");
                                          v = await updateVerified(email);
                                          print(v.message);
                                          Alert(
                                            context: context,
                                            title: "",
                                            desc: "Your Accout is verified Go to SignIn",
                                            image: Image.asset("assets/images/tick.png",width: 70,height: 70,),
                                            buttons: [
                                              DialogButton(
                                                child: Text(
                                                  "Ok",
                                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(builder: (context) => Authentification()));
                                                },
                                                color: Color(0xffb97898),
                                              ),

                                            ],
                                          ).show();
                                        }
                                      },
                                      child: Text(
                                        "Done",
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ]).show();

                            }
                          }
                          else if(!isSignupScreen){
                            response = await http.post(
                              base_url+"/parents/signInParent",
                              headers: <String, String>{
                                'Content-Type': 'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(<String, String>{
                                "email":emailin,"password":passwordin,
                              }),
                            );
                            print(response.body);





                            text6=emailLoginController.text;
                            text7=passwordLoginController.text;
                            var parse = jsonDecode(response.body);
                            String test = parse["message"];
                            String idParent = parse["_id"];
                            String firstnameParent = parse["firstname"];
                            String lastnameParent = parse["lastname"];

                            print(idParent);
                            print(test);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('idParent', idParent);
                            prefs.setString('firstnameParent', firstnameParent);
                            prefs.setString('lastnameParent', lastnameParent);

                            if(test=="Authentication failed. User not found."){
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "",
                                desc: "User not found",
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
                             if(test=="Authentication failed. Wrong password."){
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "",
                                desc: "Wrong password",
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
                            if(test=="Login successfully"){

                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Menu()));

                            }

                            if ( text6 == '' || text7 == ''){
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "",
                                desc: "Fields must not be empty.",
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




                          }
                        },


                      ),
                    ) : Center(),
                  ),
                )
            ),
          ],
        ),

      ),);
  }
}


signUp(firstname, lastname, phone, email, password) async{
  var url = base_url+"/parents/signUpParent";
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'firstname': firstname,'lastname':lastname,"email":email,"phone":phone,"password":password,
    }),
  );
  print(response.body);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var parse = jsonDecode(response.body);


  await prefs.setString('token', parse["token"]);

  String token = prefs.getString("token");
  print(token);
}


Future<sendMailClassAuth> sendMailAuth(email) async {
  await Future<sendMailClassAuth>.delayed(const Duration(seconds: 1));
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
  return sendMailClassAuth(code: code,message: message);

}
Future<verifiedClass> updateVerified(email) async {
  //await Future<sendMailClassAuth>.delayed(const Duration(seconds: 1));
  var url = base_url+"/parents/updateVerified";
  String message;
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

  return verifiedClass(message: message);

}
class sendMailClassAuth {
  final String message;
  final String code;
  sendMailClassAuth({this.message, this.code});
}

class verifiedClass {
  final String message;

  verifiedClass({this.message});
}
