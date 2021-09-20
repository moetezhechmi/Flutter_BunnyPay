
import 'dart:convert';

import 'package:bunnypay007/config/dbconnection.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class DetailPage extends StatefulWidget {
  final String id;
  DetailPage(this.id);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List data;


  GetproductCmd() async {
    var url = base_url+"/traders/getProductCmd";
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'cmdId': widget.id,
      }),
    );
    print(response.body);

    this.setState(() {
      data = json.decode(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    GetproductCmd();
  }
  String imgPath = "assets/images/todo.png";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Product List"),
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
        backgroundColor: Color(0xFFFCFAF8),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(

                child: FutureBuilder(

                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(data!= null){
                        return Padding(
                            padding: EdgeInsets.all(5),
                            child:
                            GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
                                      child: InkWell(

                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey.withOpacity(0.2),
                                                        spreadRadius: 3.0,
                                                        blurRadius: 5.0)
                                                  ],
                                                  color: Colors.white),
                                              child: Column(children: [

                                                Hero(
                                                    tag: imgPath,
                                                    child: Container(
                                                        height: 120.0,
                                                        width: 400.0,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                              image: NetworkImage(base_url_image+data[index]["photo"]),
                                                            )))),
                                                SizedBox(height: 7.0),

                                                Text(data[index]["name"],
                                                    style: TextStyle(
                                                        color: Color(0xffb97898),

                                                        fontFamily: 'Varela',
                                                        fontSize: 12.0)),

                                                Text("Price: "+ data[index]["price"]+" millimes",
                                                    style: TextStyle(
                                                        color: Color(0xFF575E67),
                                                        fontFamily: 'Varela',
                                                        fontSize: 14.0)),
                                                Text("Quantity: "+ data[index]["quantite"],
                                                    style: TextStyle(
                                                        color: Color(0xFF575E67),
                                                        fontFamily: 'Varela',
                                                        fontSize: 14.0)),


                                              ]))));
                                }
                            )
                        );
                      }
                      else if(snapshot.hasError){
                        return Container(
                          child: Center(child: Text('Not Found Data')),
                        );
                      }         else{
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    })
            )
          ],
        )
    );
  }

}
