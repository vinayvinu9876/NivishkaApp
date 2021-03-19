import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'Bookings.dart';

class BookingHistory extends StatefulWidget {
  @override
  State<BookingHistory> createState() => _BookingHistory();
}

class _BookingHistory extends State<BookingHistory> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: DefaultTabController(
            length: 3,
            child: Scaffold(
                bottomNavigationBar: CustomBottomNavBar(),
                appBar: AppBar(
                  leading: Icon(Icons.arrow_back),
                  title: Text("My Bookings",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 14)),
                  bottom: TabBar(
                    labelStyle: GoogleFonts.poppins(fontSize: 12),
                    tabs: [
                      Tab(text: "Scheduled"),
                      Tab(text: "Completed"),
                      Tab(text: "Cancelled"),
                    ],
                  ),
                ),
                body: Container(
                    height: height,
                    width: width,
                    child: TabBarView(children: [
                      Bookings(),
                      Bookings(),
                      Bookings(),
                    ])))));
  }
}
