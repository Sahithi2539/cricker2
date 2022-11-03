// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// class LocPage extends StatefulWidget {
//   @override
//   _LocPageState createState() => _LocPageState();
// }

// class _LocPageState extends State<LocPage> {
//   late Position _currentPosition;
//   late String _currentAddress;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Location"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (_currentPosition != null)
//               Text(
//                   "LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}"),
//             ElevatedButton(
//               child: Text("Get location"),
//               onPressed: () {
//                 _getCurrentLocation();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _getCurrentLocation() {
//     Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.best,
//             forceAndroidLocationManager: true)
//         .then((Position position) {
//       setState(() {
//         _currentPosition = position;
//       });
//     }).catchError((e) {
//       print(e);
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double long;
  late double lat;
  late String _currentAddress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // if (lat == null) Text('errorrr'),
            TextButton(
              child: Text("Get location"),
              onPressed: () {
                getlocation();
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
      List<Placemark> placemarks = await placemarkFromCoordinates(long, lat);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        print("${place.locality}, ${place.postalCode}, ${place.country}");
      });
    } catch (e) {
      print(e);
    }
  }
}
