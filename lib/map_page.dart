import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:simple_flutter_map/LogInScreen.dart';
import 'package:simple_flutter_map/list_page.dart';
import 'package:location/location.dart';
//import 'package:simple_flutter_map/location_list.dart';



class MapPage extends StatefulWidget {
  static String id = 'map_page';

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User user;
  Location _location = new Location();


  @override
  void initState() {
    user = auth.currentUser;

  }

  DatabaseReference dbRef =
      FirebaseDatabase.instance.reference().child('location');
  List<LatLng> listLocs = [
    LatLng(51.51, -0.09),
    LatLng(51.44, -0.09),
    LatLng(51.45, -0.09),
    LatLng(51.50, -0.09),
  ];
  MapController mapController = MapController();

  LatLng myCurrentLocation = LatLng(51.5, -0.09);


  @override
  Widget build(BuildContext context) {
    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Color(0xff000725)),
              onPressed: (
                  ) {},
            ),
            IconButton(
              icon: Icon(Icons.location_on, color: Color(0xff000725)),

                onPressed: () async {
                  final LocationData position = await getLoc();
                  myCurrentLocation =
                      LatLng(position.latitude, position.longitude);
                  print(position);
                  mapController.move(myCurrentLocation, 13);
                  listLocs.add(myCurrentLocation);
                  setState(() async {
                    await uploadToDatabase(position.latitude, position.longitude);
                  });
                },

            ),
            IconButton(
              icon: Icon(Icons.history, color: Color(0xff000725)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ListPage(title: 'Location History');
                }));

              },
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app,color: Color(0xff000725)),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LogInScreen();
                }));

              },
            )
          ],
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Map'),
          backgroundColor:  Color(0xffff2fc3),

        ),
        bottomNavigationBar: makeBottom,
        body: customMap(),
      ),
    );
  }

  Widget customMap() {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: myCurrentLocation,
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        MarkerLayerOptions(
          markers: [
            for (LatLng each in listLocs) ...[
              Marker(
                width: 80.0,
                height: 80.0,
                point: each,
                builder: (ctx) => Container(
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Future<LocationData> getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }


    return await _location.getLocation();
  }

  uploadToDatabase(double lati, double longi) async {
    try {
      DatabaseReference databaseRef = dbRef.push();

      await databaseRef.set({
        'uid': user.uid,
        'latitude': lati,
        'longituden': longi,
      });

      print("Your item was saved successfully");

      // StaticMethods.showErrorDialog(context: context, text: 'Your item was saved successfully');

    } catch (e) {
      print("sth went wrong");

      // StaticMethods.showErrorDialog(context: context, text: 'sth went wrong');
      print(e);
    }
  }
}
