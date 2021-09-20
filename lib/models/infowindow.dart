import 'dart:io';
import './Shop.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class InfoWindowModel extends ChangeNotifier{
  bool _showInfowindow = false;
  bool _tempHidden = false;
  Shop _shop;
  double _leftMargin;
  double _topMargin;

  void rebuildInfowindow(){
    notifyListeners();
  }
  void updateShop(Shop shop){
    _shop = shop;
  }
  void updateVisibility(bool visibility ){
    _showInfowindow = visibility;
  }
  void updateInfowindow(BuildContext context,
      GoogleMapController controller,
      LatLng location ,
      double infoWindowWidth,
      double markerOffest,
      ) async{
    ScreenCoordinate screenCoordinate = await controller.getScreenCoordinate(location);
    double devicePixelRatio = Platform.isAndroid ? MediaQuery.of(context).devicePixelRatio : 1.0;
    double left = (screenCoordinate.x .toDouble() / devicePixelRatio) - (infoWindowWidth / 2);
    double top = (screenCoordinate.x .toDouble() / devicePixelRatio) - markerOffest;
    if( left<0 || top<0){
      _tempHidden = true;
    }else{
      _tempHidden = false;
      _leftMargin = left;
      _topMargin = top;
    }
  }
  bool get showInfoWindow =>
      (_showInfowindow == true && _tempHidden == false ) ? true : false;
  double get leftMargin => _leftMargin;
  double get topMargin => _topMargin;
  Shop get shop => _shop;

}
