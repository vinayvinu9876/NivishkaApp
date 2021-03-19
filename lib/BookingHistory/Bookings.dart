import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class Bookings extends StatefulWidget {
  @override
  State<Bookings> createState() => _Bookings();
}

class _Bookings extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: height,
            width: width,
            color: Colors.grey[200],
            padding: EdgeInsets.all(10),
            child: ListView(children: [
              Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                      padding: EdgeInsets.only(
                        left: 15,
                        top: 15,
                        bottom: 15,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Text("20th",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black)),
                                        Text("March, Wednesday",
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 10)),
                                      ])),
                                  Container(
                                      height: 40,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          border: Border.all(
                                            width: 0.6,
                                            color: Colors.grey[100],
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(20))),
                                      child: Center(
                                          child: Text("₹ 800",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.bold))))
                                ]),
                            SizedBox(height: 20),
                            Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Text("Head Massage service",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12)),
                                  Text("01:55 PM - 2:55 PM",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black54, fontSize: 8)),
                                  Text("12th main JC Nagar,Kurubarahalli",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black54, fontSize: 8)),
                                ])),
                            Container(
                                padding: EdgeInsets.only(right: 10),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            Text("BOOK AGAIN",
                                                style: GoogleFonts.poppins(
                                                    color: blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8)),
                                            SizedBox(width: 10),
                                            Text("REVIEW",
                                                style: GoogleFonts.poppins(
                                                    color: blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 8))
                                          ]))
                                    ]))
                          ])))
            ])));
  }
}
