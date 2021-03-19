import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class ServiceLocationSelect extends StatefulWidget {
  @override
  State<ServiceLocationSelect> createState() => _ServiceLocationSelect();
}

class _ServiceLocationSelect extends State<ServiceLocationSelect> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 3,
                leading: Icon(Icons.arrow_back, color: Colors.black),
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
                                color: blue,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.location_on,
                                        color: Colors.white),
                                    SizedBox(width: 10),
                                    Text("Your Current Location",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ))
                                  ]))),
                      SizedBox(height: 20),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, "/selectOtherLocation");
                          },
                          child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(width: 1, color: blue)),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Some other Location",
                                        style: GoogleFonts.poppins(
                                          color: blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ))
                                  ])))
                    ]))));
  }
}
