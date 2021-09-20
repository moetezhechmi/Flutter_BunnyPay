import 'dart:convert';

import 'package:bunnypay007/config/dbconnection.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../models/Shop.dart';
import '../models/infowindow.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'package:http/http.dart' as http;

class location extends StatefulWidget {
  @override
  _locationState createState() => _locationState();
}

class _locationState extends State<location> {
  List data;
  var parse;
  String name;
  String description;
  String latitude;
  String longitude;
  GetShops() async{
    var url = base_url+"/traders/getallshop";



    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },

    );


    this.setState(() {
      data = json.decode(response.body);
    });
    parse = jsonDecode(response.body);
    print(data);
    for(int i =0;i<data.length;i++){
      name = data[i]['name'];
      description = data[i]['description'];
      latitude = data[i]['latitude'];
      longitude = data[i]['longitude'];

    }


    print(name);
    print(description);print(latitude);print(longitude);

  }
  GoogleMapController mapController;
  Set<Marker> _markers = Set<Marker> ();

  final LatLng _center = LatLng(36.8992047, 10.1875152);
  final double _zoom = 15.0;

  final Map<String, Shop> _shopList = {
    "Baguette" : Shop('chaneb',
        'fast food',
        LatLng(36.9009253, 10.182296),
        'assets/images/baguette.png'
    ),
    "Esprit" : Shop('Esprit',
        'Buvette',
        LatLng(36.900788, 10.1851928),
        'assets/images/Carrefour.png'
    ),
  };
  final double _infoWindoWidth = 250;
  final double _markerOffest = 170;

  @override
  Widget build(BuildContext context) {
    final providerObject = Provider.of<InfoWindowModel>(context, listen: false);
    _shopList.forEach((key, value) {
      _markers.add(
        Marker(
          markerId: MarkerId(value.name),
          position: value.location,
          onTap: () {
            providerObject.updateInfowindow(
              context,
              mapController,
              value.location,
              _infoWindoWidth,
              _markerOffest,
            );
            providerObject.updateShop(value);
            providerObject.updateVisibility(true);
            providerObject.rebuildInfowindow();
          },
        ),
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop Location"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Color(0xff511f52), Color(0xffb97898)])),
        ),
      ),
      body: Container(
        child: Consumer<InfoWindowModel>(
          builder: (context, model, child) {
            return Stack(
              children: [
                child,
                Positioned(
                  left: 0,
                  top: 0,
                  child: Visibility(
                    visible: providerObject.showInfoWindow,
                    child: (providerObject.shop ==  null ||
                        !providerObject.showInfoWindow)
                        ? Container()
                        : Container(
                      margin: EdgeInsets.only(
                        left: providerObject.leftMargin,
                        top: providerObject.topMargin,
                      ),

                      child: Column(
                        children: [
                          Container(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white,
                                  Color(0xfffceef5),
                                ],
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 6.0
                                ),
                              ],
                            ),
                            height: 115,
                            width: 250,
                            padding: EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                    providerObject.shop.image,
                                    height: 75
                                ),

                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(providerObject.shop.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:  Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),

                                    IconButton(
                                      alignment: Alignment.topRight,
                                      icon: Icon(Icons.visibility,color: Color(0xc4511f52),),
                                      onPressed: () {
                                        GetShops();


                                        Alert(
                                          context: context,

                                          title: providerObject.shop.name,
                                          desc: providerObject.shop.description,

                                        ).show();
                                      },
                                    ),


                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          child: Positioned(
            child: GoogleMap(
              onTap: (position){
                if( providerObject.showInfoWindow){
                  providerObject.updateVisibility(false);
                  providerObject.rebuildInfowindow();
                }

              },
              onCameraMove: (position){
                if(providerObject.shop != null){
                  providerObject.updateInfowindow(
                    context,
                    mapController,
                    providerObject.shop.location,
                    _infoWindoWidth,
                    _markerOffest,
                  );
                  providerObject.rebuildInfowindow();
                }
              },
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: _zoom,
              ),
            ),
          ),
        ),
      ),
    );
  }
}



