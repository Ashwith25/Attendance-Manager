import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MyLocation {
  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // print(placemarks);
    Placemark place = placemarks[0];
    var address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    // locai

    // print(position.latitude.runtimeType);
    // final coordinates = Coordinates(position.latitude, position.longitude);
    // var address =
    //     await Geocoder.local.findAddressesFromCoordinates(coordinates);


    return position;
    // print("Name: ${address.first.} and ${address.first.addressLine}");
  }
}
