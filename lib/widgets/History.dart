import 'dart:async';
import 'dart:convert';



import 'package:bunnypay007/config/calendar_strip.dart';
import 'package:bunnypay007/config/dbconnection.dart';
import 'package:bunnypay007/config/history_service.dart';
import 'package:bunnypay007/models/Commande.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'detail_page.dart';

class History extends StatefulWidget {
  History({Key key,this.title}) : super(key: key);
  final Commande title;
  @override
  _HistoryState createState() => _HistoryState();
}



class _HistoryState extends State<History> {

  List lcom ;
  History() async{
    var url = base_url+"/traders/test";

    SharedPreferences prefs1 = await SharedPreferences.getInstance();
    //Return int
    var parentId = prefs1.getString("idParent");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'parentId': parentId,
      }),
    );
    lcom = json.decode(response.body);
  }
  var value;

  DateTime startDate = DateTime.now().subtract(Duration(days: 100));
  DateTime endDate = DateTime.now().add(Duration(days: 100));
  DateTime selectedDate = DateTime.now();
  List<DateTime> markedDates = [];
  List datesData = [];
  var datefuture = [];
  var cmd = [];
  var totalList = [];
  bool start = false;
  List<int> totalwidget = [];
  DateFormat dateFormat = DateFormat("HH:mm");

  getc() async {
    Future<List<Commande>> _futureOfList = getCommande();
    List<Commande> list = await _futureOfList ;


    String string = dateFormat.format(DateTime.parse(list[0].date));
    print(string);
    setState(() {

      for (var j =0;j< list.length;j++) {
        DateTime d= DateTime.parse(list[j].date);
        cmd.add({"id":list[j].id,"date":DateTime.parse(DateFormat('yyyy-MM-dd').format(d)),"child":list[j].child,"childimg":list[j].childimg,"prodtotal":list[j].prodtotal,"total":list[j].total,"shop":list[j].shop,"time":dateFormat.format(DateTime.parse(list[j].date))});

      }

    });



    for (int i = 0; i < cmd.length; i++) {
      print(cmd[i]);

      setState(() {
        markedDates.add(cmd[i]["date"]);
        //print(markedDates);
        if(DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())) == cmd[i]["date"]){
          selectedDate = cmd[i]["date"];
          datesData=cmd[i];


        }
      });

    }
  }
  final df = new DateFormat('dd-MM-yyyy');


  @override
  void initState() {
    getc();
    super.initState();
  }

  onSelect(data) {
    setState(() {
      start = false;
      datesData.clear();

    });

    for (int i = 0; i < cmd.length; i++) {
      if(DateTime.parse(DateFormat('yyyy-MM-dd').format(data)) == cmd[i]["date"]){
        setState(() {
          datesData.add(cmd[i]);
          start = true;


        });
      }

    }

  }

  onWeekSelect(data) {

  }

  _monthNameWidget(monthName) {
    return Container(
      child: Text(
        monthName,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          fontStyle: FontStyle.italic,
        ),
      ),
      padding: EdgeInsets.only(top: 8, bottom: 4),
    );
  }

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1),
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xff511f52)),
      ),
      Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xffb97898)),
      )
    ]);
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
    TextStyle normalStyle =
    TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);
    TextStyle dayNameStyle = TextStyle(fontSize: 14.5, color: fontColor);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    if (isDateMarked == true) {
      _children.add(getMarkedIndicatorWidget());
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Color(0x66b97898),
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    History();

    return Scaffold(
        appBar: AppBar(
          title: Text("History"),
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
        body: ListView(
            children: <Widget>[
              Container(
                  child: CalendarStrip(
                    startDate: startDate,
                    endDate: endDate,
                    selectedDate: selectedDate,
                    onDateSelected: onSelect,
                    onWeekSelected: onWeekSelect,
                    dateTileBuilder: dateTileBuilder,
                    iconColor: Colors.black,
                    monthNameWidget: _monthNameWidget,
                    markedDates: markedDates,
                    addSwipeGesture: true,
                  )),

              start ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: datesData.length,
                  itemBuilder: (BuildContext context, i) {


                    return new ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children:  <Widget> [
                        Row(
                          children: <Widget>[
                            SizedBox(height: 50,),
                            SizedBox(height: 15,width: 30,
                              child: Container(
                                child: Material(
                                  color: Color(0xffb97898),
                                  borderRadius: BorderRadius.horizontal(
                                      left: Radius.zero,
                                      right: Radius.circular(60)
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(" ${datesData[i]["time"]}", style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),),
                            ),

                          ],
                        ),
                        Container(

                          height: 290,

                          padding: EdgeInsets.only(left: 10, right: 10),

                          child: Card(

                            color: Color(0xfff5f4f4),



                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading:CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage:
                                    NetworkImage(base_url_image+"/uploads/image_picker_6A8F6D7E-4B27-40B8-9986-0C94F295664E-6130-000004A09E5664F9.jpg"),
                                    backgroundColor: Colors.transparent,
                                  ),
                                  title: Text("${datesData[i]["child"]}", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xffb97898)),),

                                ),
                                ListTile(


                                  title: Row(
                                    children: [
                                      Text("Commande Total:",  style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff511f52))),
                                      Text(" ${datesData[i]["total"]} millimes",style: TextStyle(color: Colors.black),)
                                    ],
                                  ),
                                ),
                                ListTile(
                                  title: Row(
                                    children: [
                                      Text("Number of products purchased: ",  style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff511f52))),
                                      Text(" ${datesData[i]["prodtotal"]}",style: TextStyle(color: Colors.black),),
                                    ],
                                  ),
                                ),
                                ListTile(
                                  title: Row(
                                    children: [
                                      Text("Shop Name: ",  style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff511f52))),
                                      Text(" ${datesData[i]["shop"]}",style: TextStyle(color: Colors.black),),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left:230.0 ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [Color(0xff511f52), Color(0xffb97898)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight
                                      ),
                                      borderRadius: BorderRadius.circular(30),

                                    ),

                                    child:
                                    //Icon(Icons.arrow_forward,color: Colors.white,),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text("Product List",style: TextStyle(color: Colors.white),),
                                        ),
                                        IconButton(
                                          icon: new Icon(Icons.arrow_forward),
                                          color: Colors.white,
                                          onPressed: (){
                                            Navigator.push(context,
                                                new MaterialPageRoute(builder: (context)
                                                => DetailPage(datesData[i]["id"])));
                                          },

                                        ),
                                      ],
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }):  Center(
                child: Padding(
                  padding: EdgeInsets.only(top:300 ),
                  child: Text('No Command in this date'),
                ),
              ),


            ]

        )
    );
  }
}

