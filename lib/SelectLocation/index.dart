import 'package:flutter/material.dart';
import 'dart:async';
import 'package:nivishka_android/util/index.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class SelectLocation extends StatefulWidget {
  @override
  State<SelectLocation> createState() => _SelectLocation();
}

class _SelectLocation extends State<SelectLocation> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        bottom: true,
        top: true,
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.green[600],
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:
                        Icon(Icons.arrow_back, color: Colors.white, size: 20)),
                title: Text("Plumbers",
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: Colors.white))),
            body: Container(
                height: height,
                width: width,
                color: Colors.grey[100],
                child: Container(
                    child: Stack(children: [
                  Container(
                      height: height * 0.61, width: width, child: MapSample()),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Container(
                              height: height * 0.45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: ListView(children: [
                                SizedBox(height: 20),
                                Container(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: TextField(
                                        style:
                                            GoogleFonts.poppins(fontSize: 12),
                                        decoration: InputDecoration(
                                            suffix: Text("Change",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    color: Colors.blue[800],
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            contentPadding: EdgeInsets.only(
                                                left: 15,
                                                right: 10,
                                                bottom: 5,
                                                top: 5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[100]),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            labelText: "Your Location",
                                            labelStyle: GoogleFonts.poppins(
                                                color: Colors.grey[400],
                                                fontSize: 12)))),
                                SizedBox(height: 15),
                                Container(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: TextField(
                                        style:
                                            GoogleFonts.poppins(fontSize: 12),
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                left: 15,
                                                right: 10,
                                                bottom: 5,
                                                top: 5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[100]),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            labelText: "Flat/Building/Street",
                                            labelStyle: GoogleFonts.poppins(
                                                color: Colors.grey[400],
                                                fontSize: 12)))),
                                SizedBox(height: 15),
                                Container(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: TextField(
                                        style:
                                            GoogleFonts.poppins(fontSize: 12),
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                left: 15,
                                                right: 10,
                                                bottom: 5,
                                                top: 5),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[100]),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            labelText: "Your Name",
                                            labelStyle: GoogleFonts.poppins(
                                                color: Colors.grey[400],
                                                fontSize: 12)))),
                                SizedBox(height: 15),
                                Container(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, bottom: 5),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Save as",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.grey[400],
                                                  fontSize: 12)),
                                          SizedBox(height: 5),
                                          Container(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 2,
                                                        bottom: 2),
                                                    child: Text('Home',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ))),
                                                SizedBox(width: 10),
                                                Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 2,
                                                        bottom: 2),
                                                    child: Text('Office',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ))),
                                                SizedBox(width: 10),
                                                Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.green[600],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    padding: EdgeInsets.only(
                                                        left: 10,
                                                        right: 10,
                                                        top: 2,
                                                        bottom: 2),
                                                    child: Text('Others',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                        ))),
                                              ]))
                                        ])),
                                SizedBox(height: 10),
                                Expanded(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                          color: Colors.grey[100],
                                        ))),
                                        padding: EdgeInsets.all(10),
                                        child: Center(
                                            child: InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, "/selectDate");
                                                },
                                                child: Container(
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      color: Colors.green[600],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Center(
                                                        child: Text(
                                                            "Add Flat /  Building / Street",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    color: Colors
                                                                        .white))))))))
                              ]))))
                ])))));
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  static const LatLng _center = const LatLng(12.9716, 77.5946);

  Future<void> _onMapCreated(GoogleMapController controller) async {
    //Position position = await _determinePosition();
    //_add(position);
    _controller.complete(controller);
  }

  _onMarkerTapped(markerId) {
    print("Tapped on marker $markerId");
  }

  void _add(position) {
    var markerIdVal = "1";
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        position.latitude,
        position.longitude,
      ),
      onTap: () {
        _onMarkerTapped(markerId);
      },
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  _onCameraMove(CameraPosition position) {
    print(position.target);
    _add(position.target);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: Set<Marker>.of(markers.values),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 17.0,
        ),
        onCameraMove: _onCameraMove,
      ),
    );
  }
}
