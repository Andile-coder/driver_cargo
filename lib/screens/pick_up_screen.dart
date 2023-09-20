import 'package:driver_cargo/assistantMethods/get_current_location.dart';
import 'package:driver_cargo/components/progress_bar.dart';
import 'package:driver_cargo/screens/qr_code_scanner_scrren.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart' as LatLng;
import "package:http/http.dart" as http;
import "dart:convert" as convert;
import 'package:geocoding/geocoding.dart';
// import 'package:location/location.dart' as Location;

class PickupScreen extends StatefulWidget {
  final Map<dynamic, dynamic> order;
  const PickupScreen({super.key, required this.order});

  @override
  State<PickupScreen> createState() => _PickupScreenState();
}

class _PickupScreenState extends State<PickupScreen> {
  final String apiKey = "JBygABhXcMWTsatfDipt4w1cJCIh6fK0";
  // Location.LocationData? _currentPosition;
  String? _address;
  Position? driverCo;

  // Location.Location location = Location.Location();
  getDriverLocation() {
    //get driver current phone location
  }
  getOrderOriginLocation() {
    print(widget.order);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserLocation uLocation = UserLocation();
    getUserLocation() async {
      driverCo = await uLocation.getCurrenLocation();
      print(driverCo);
      setState(() {});
    }

    getUserLocation();
    // getOrderOriginLocation();
  }

  @override
  Widget build(BuildContext context) {
    String origin = widget.order["pickup_address"];
    double originLat = double.parse(origin.split(',')[0]);
    double originLng = double.parse(origin.split(',')[1]);
    var originCo = LatLng.LatLng(originLat, originLng);
    //driver cordinates

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: originCo,
                zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://api.tomtom.com/map/1/tile/basic/main/"
                      "{z}/{x}/{y}.png?key={apiKey}",
                  additionalOptions: {"apiKey": apiKey},
                ),
                driverCo != null
                    ? PolylineLayer(
                        polylineCulling: true,
                        polylines: [
                          Polyline(
                            points: [
                              LatLng.LatLng(
                                  originCo.latitude, originCo.longitude),
                              LatLng.LatLng(driverCo?.latitude as double,
                                  driverCo?.longitude as double)
                            ],
                            color: Colors.red,
                          )
                        ],
                      )
                    : circularProgress(),
                driverCo != null
                    ? MarkerLayer(
                        markers: [
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng.LatLng(
                                originCo.latitude, originCo.longitude),
                            builder: (BuildContext context) => const Icon(
                                Icons.location_on,
                                size: 60.0,
                                color: Colors.black),
                          ),
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: LatLng.LatLng(driverCo?.latitude as double,
                                driverCo?.longitude as double),
                            builder: (BuildContext context) => const Icon(
                                Icons.location_on,
                                size: 60.0,
                                color: Color.fromARGB(255, 147, 36, 36)),
                          )
                        ],
                      )
                    : circularProgress(),
              ],
            ),
            Container(
                padding: EdgeInsets.fromLTRB(30, 600, 30, 30),
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const QrCodeScannerScreen()),
                        ),
                      );
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(3.0, -1.0),
                          colors: [
                            Color(0xFF004B8D),
                            Color(0xFFffffff),
                          ],
                        ),
                      ),
                      width: 200,
                      height: 50,
                      child: const Center(
                          child: Text(
                        "Arrived",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      )),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
