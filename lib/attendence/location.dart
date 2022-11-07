import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricker/addcriminals/image.dart';
import 'package:cricker/read%20data/get_user_name.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cricker/read data/get_pincode.dart';
import 'package:path/path.dart';
import 'package:cricker/read data/getpin.dart';

class HomePage extends StatefulWidget {
  final String value;
  const HomePage({
    Key? key,
    required this.value,
  }) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double long;
  late double lat;
  late String _currentAddress = '';
  late dynamic valloc;
  @override
  Widget build(BuildContext context) {
    GetPinCode val;
    String add;
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_currentAddress != null) Text('Current: '),
            Text(_currentAddress),
            SizedBox(height: 10),
            Text('Record: '),
            // Text(widget.value),
            GetPinCode(value: widget.value),
            TextButton(
              child: Text("Get location"),
              onPressed: () {
                getlocation();
                _getAddressFromLatLng();
                valloc = GetPinCode(value: widget.value);
                print(valloc);
                verificationLoc(
                  valloc,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void getlocation() async {
    LocationPermission per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied ||
        per == LocationPermission.deniedForever) {
      print("permission denied");
      LocationPermission per1 = await Geolocator.requestPermission();
    } else {
      print('i am there');
      Position currentLoc = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        long = currentLoc.longitude;
        lat = currentLoc.latitude;
      });
    }
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

      Placemark place = placemarks[0];
      // print("${place.locality}, ${place.postalCode}, ${place.country}");
      setState(() {
        _currentAddress = "${place.postalCode}";
        print("${place.locality}, ${place.postalCode}, ${place.country}");
        print('address');
      });
    } catch (e) {
      print(e);
    }
  }

  void verificationLoc(dynamic val) {
    print("val");
    print(val.value);
    if (_currentAddress.toString() == val.toString()) print('VERIFIED');
    if (_currentAddress.toString() != val.toString()) print('NOT VERIFIED');
  }
}
