import 'package:geolocator/geolocator.dart';

class MyLocation {
  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
        
    return position;
  }
}
