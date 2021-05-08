import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:provider/provider.dart';
import 'package:nivishka_android/SelectLocation/SelectLocationModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceLocationSelect extends StatefulWidget {
  @override
  State<ServiceLocationSelect> createState() => _ServiceLocationSelect();
}

class _ServiceLocationSelect extends State<ServiceLocationSelect> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var selectLocationModel =
        Provider.of<SelectLocationModel>(context, listen: false);
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 3,
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.black)),
                centerTitle: true,
                title: Text("Plumbers",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ))),
            body: Container(
                height: height,
                width: width,
                padding: EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 50),
                      Text("Where do you want the Service ? ",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 40),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/selectLocation");
                          },
                          child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.location_on,
                                        color: Colors.black),
                                    SizedBox(width: 10),
                                    Text("Your Current Location",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ))
                                  ]))),
                      SizedBox(height: 20),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlacePicker(
                                  apiKey:
                                      "AIzaSyAAiZfeAjYpyxGyFIF82EkApRWLyDAHXrY", // Put YOUR OWN KEY here.
                                  onPlacePicked: (PickResult result) {
                                    print("$result");
                                    selectLocationModel.setCurrentPosition(
                                        LatLng(result.geometry.location.lat,
                                            result.geometry.location.lng));
                                    Navigator.pushNamed(
                                        context, "/selectLocation");
                                  },
                                  initialPosition: LatLng(12.9716, 77.5946),
                                  useCurrentLocation: true,
                                ),
                              ),
                            );
                          },
                          child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1, color: primaryColor)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Some other Location",
                                        style: GoogleFonts.poppins(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ))
                                  ])))
                    ]))));
  }
}
