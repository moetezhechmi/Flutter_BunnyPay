import 'package:google_maps_flutter/google_maps_flutter.dart';

class Shop {
  final String name;
  final String description;
  final LatLng location;

  final String image;

  Shop(this.name, this.description, this.location,  this.image);
}

