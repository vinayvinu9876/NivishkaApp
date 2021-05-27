import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:nivishka_android/BookingDetails/index.dart';
import 'package:intl/intl.dart';
import 'package:nivishka_android/RateService/index.dart';
import 'package:nivishka_android/cancelOrder/index.dart';

class Bookings extends StatefulWidget {
  final List<Map<String, dynamic>> ordersData;
  final String type;
  Bookings({
    @required this.ordersData,
    @required this.type,
  });
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
              for (var i in widget.ordersData) bookingsCard(order: i),
            ])));
  }

  Widget bookingsCard({@required Map<String, dynamic> order}) {
    int d = order["create_date"].toDate().day;
    String day;
    if (d % 10 == 1) {
      day = "$d st";
    } else if (d % 10 == 2) {
      day = "$d nd";
    } else {
      day = "$d th";
    }
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    String month = months[order["create_date"].toDate().month - 1];
    String services = "";
    Map<String, dynamic> cartData = order["cartData"];
    if (cartData.keys.length > 0) {
      services += cartData[cartData.keys.first]["service_name"];
    }
    if (cartData.keys.length > 2) {
      services += "...";
    }

    String scheduleTime = "";

    if (order["delivery_date_and_time"] != null) {
      int time = order["delivery_date_and_time"]["time"];
      int hrs = (time ~/ 100).toInt();
      int mins = (time - (hrs * 100));
      if (time >= 1200 && time < 1300) {
        scheduleTime = "12: ${mins == 0 ? "00" : mins} pm";
      } else if (time >= 1300) {
        scheduleTime = "${hrs - 12} : ${mins == 0 ? "00" : mins.toString()} pm";
      } else {
        scheduleTime = " $hrs : ${mins == 0 ? "00" : mins.toString()} am";
      }
    }

    return Container(
        margin: EdgeInsets.only(top: 7, bottom: 7),
        child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Text("$day",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black)),
                                  Text(
                                      "$month, ${DateFormat('EEEE').format(order["create_date"].toDate())}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black, fontSize: 10)),
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
                                    child: Text("₹ ${order["totalCost"]}",
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))))
                          ]),
                      SizedBox(height: 15),
                      Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text("$services",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                            SizedBox(height: 5),
                            Text("Schedule $scheduleTime",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 8)),
                            SizedBox(height: 5),
                            Text(
                                "${order["deliveryLocation"] == null ? "" : order["deliveryLocation"]["placeName"]}",
                                style: GoogleFonts.poppins(
                                    color: Colors.black54, fontSize: 8)),
                          ])),
                      Container(
                          padding: EdgeInsets.only(right: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      SizedBox(width: 10),
                                      Visibility(
                                          visible: (widget.type == "completed"),
                                          child: InkWell(
                                              onTap: () {
                                                if (widget.type == "completed")
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RateService(
                                                                orderId: order[
                                                                    "order_id"])),
                                                  );
                                              },
                                              child: Text("Rate Service",
                                                  style: GoogleFonts.poppins(
                                                      color: blue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 8)))),
                                      SizedBox(width: 10),
                                      InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BookingDetails(
                                                        orderDetails: order,
                                                      )),
                                            );
                                          },
                                          child: Text("VIEW",
                                              style: GoogleFonts.poppins(
                                                  color: blue,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 8))),
                                      SizedBox(width: 10),
                                      Visibility(
                                          visible: (widget.type == "pending"),
                                          child: InkWell(
                                              onTap: () {
                                                if (widget.type == "pending")
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CancelOrder(
                                                                orderId: order[
                                                                    "order_id"])),
                                                  );
                                              },
                                              child: Text("CANCEL",
                                                  style: GoogleFonts.poppins(
                                                      color: blue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 8)))),
                                    ]))
                              ]))
                    ]))));
  }
}
