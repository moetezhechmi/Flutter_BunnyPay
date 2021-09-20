import 'package:bunnypay007/widgets/AddChild.dart';
import 'package:bunnypay007/widgets/ChildrenList.dart';
import 'package:bunnypay007/widgets/History.dart';
import 'package:bunnypay007/widgets/ReloadMoney.dart';
import 'package:bunnypay007/widgets/Settings.dart';
import 'package:bunnypay007/widgets/location.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "Locations",
      subtitle: "NFC shop",
      event: "",
      img: "assets/images/map.png");

  Items item2 = new Items(
    title: "Add Child",
    subtitle: "Register your child",
    event: "",
    img: "assets/images/add.png",
  );
  Items item3 = new Items(
    title: "Children List",
    subtitle: "2 KIDS",
    event: "",
    img: "assets/images/students.png",
  );

  Items item4 = new Items(
    title: "History",
    subtitle: "Consult purchase",
    event: "",
    img: "assets/images/todo.png",
  );
  Items item5 = new Items(
    title: "Reload money",
    subtitle: "Charge your account",
    event: "",
    img: "assets/images/wallet.png",
  );
  Items item6 = new Items(
    title: "Settings",
    subtitle: "Light/Dark mode ...",
    event: "",
    img: "assets/images/setting.png",
  );

  @override
  Widget build(BuildContext context) {
    //List<Items> myList = [item1, item2, item3, item4, item5, item6];
    var color = 0xff453658;
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => location()));
            },
            child: new Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff511f52), Color(0xffb97898)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/map.png",
                    width: 42,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "locations",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "NFC shop",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) =>PageAddChild ()));
            },
            child: new Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff511f52), Color(0xffb97898)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/add.png",
                    width: 42,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Add Child",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Register your child",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: new Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff511f52), Color(0xffb97898)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/students.png",
                    width: 42,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Children List",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "2 KIDS",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => History()));
            },
            child: new Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff511f52), Color(0xffb97898)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/todo.png",
                    width: 42,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "History",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Consult purchase",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReloadMoney()));

            },
            child: new Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff511f52), Color(0xffb97898)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/wallet.png",
                    width: 42,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Reload money",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Charge your account",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings()));
            },
            child: new Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xff511f52), Color(0xffb97898)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/setting.png",
                    width: 42,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Settings",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Light/Dark mode ...",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white38,
                            fontSize: 10,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Items {
  String title;
  String subtitle;
  String event;
  String img;

  Items({this.title, this.subtitle, this.event, this.img});
}

