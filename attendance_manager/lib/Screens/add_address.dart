import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class GooogleMap extends StatefulWidget {
  final Function setAddress;
  final String lat;
  final String long;

  const GooogleMap({
    Key? key,
    required this.setAddress,
    required this.lat,
    required this.long,
  }) : super(key: key);
  @override
  _GooogleMapState createState() => _GooogleMapState();
}

class _GooogleMapState extends State<GooogleMap> {
  // Completer<GoogleMapController> _controller = Completer();

  double? long;
  double? lat;
  Set<Marker> _createMarker() {
    return {
      Marker(
        markerId: const MarkerId("marker_2"),
        position: LatLng(lat!, long!),
      ),
    };
  }

  @override
  void initState() {
    lat = double.parse(widget.lat);
    long = double.parse(widget.long);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(lat!, long!),
      zoom: 14.4746,
    );
    return GoogleMap(
      onTap: (argument) {
        setState(() {
          lat = argument.latitude;
          long = argument.longitude;
        });
        widget.setAddress(lat, long);
      },
      markers: _createMarker(),
      initialCameraPosition: _kGooglePlex,
    );
  }
}

class AddressScreen extends StatefulWidget {
  final Position position;
  const AddressScreen({Key? key, required this.position}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  double? lat;
  double? long;
  String? address = "Your address goes here";

  setAddress(double lat, double long) async {
    this.lat = lat;
    this.long = long;
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    Placemark place = placemarks[0];
    address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    setState(() {
      _address.text = address!;
    });
  }

  @override
  void initState() {
    super.initState();
    setAddress(widget.position.latitude, widget.position.longitude);
  }

  final TextEditingController _address = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: GooogleMap(
              setAddress: setAddress,
              lat: widget.position.latitude.toString(),
              long: widget.position.longitude.toString(),
            ),
          ),
          Form(
            key: _formKey,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: size.height * 0.25,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: TextFormField(
                        readOnly: true,
                        controller: _address,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Address can't be empty";
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                            helperStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: "Address",
                            labelStyle: TextStyle(color: Colors.white))),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: MaterialButton(
                      minWidth: 100,
                      height: 60,
                      color: goldenColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        "Update",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('address', address!);
                        Navigator.of(context).pop(address);
                      },
                    ),
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
