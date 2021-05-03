import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class BookingDetails extends StatefulWidget {
  @override
  State<BookingDetails> createState() => _BookingDetails();
}

class _BookingDetails extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            bottomNavigationBar: bottomNavBar(),
            body: Container(
              height: height,
              width: width,
              child: ListView(children: [
                topBar(),
                SizedBox(height: 10),
                serviceTimeAndLocation(),
                billDetails(),
                partnerDetails(),
                paymentDetails(),
              ]),
            )));
  }

  Widget paymentDetails() {
    Widget keyValue({@required String key, @required String value}) {
      return Container(
          padding: EdgeInsets.only(top: 3, bottom: 3),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$key",
                    style: GoogleFonts.poppins(
                        color: Colors.grey[500], fontSize: 10)),
                SizedBox(height: 1),
                Text("$value",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w500))
              ]));
    }

    return Container(
        padding: EdgeInsets.all(
          10,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Payment Details",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              keyValue(key: "Payment Amount", value: "₹ 540"),
              keyValue(key: "Payment Method", value: "netbanking"),
              keyValue(key: "Payment Status", value: "captured"),
              keyValue(key: "Ratings", value: "4.5"),
            ]));
  }

  Widget bottomNavBar() {
    double width = MediaQuery.of(context).size.width;
    return Container(
        width: width,
        padding: EdgeInsets.all(15),
        child: Row(children: [
          Expanded(
              flex: 5,
              child: Container(
                  height: 40,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topCenter,
                        colors: gradient,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Text("Rate Service",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500))))),
          SizedBox(width: 10),
          Expanded(
              flex: 5,
              child: Container(
                  height: 40,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topCenter,
                        colors: gradient,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Text("Need Help",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500))))),
        ]));
  }

  Widget partnerDetails() {
    Widget keyValue({@required String key, @required String value}) {
      return Container(
          padding: EdgeInsets.only(top: 3, bottom: 3),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$key",
                    style: GoogleFonts.poppins(
                        color: Colors.grey[500], fontSize: 10)),
                SizedBox(height: 1),
                Text("$value",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w500))
              ]));
    }

    return Container(
        padding: EdgeInsets.all(
          10,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Partner Details",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Container(
                  height: 120,
                  child: Row(children: [
                    Expanded(
                        flex: 3,
                        child: Image(
                            height: 120,
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://www.irreverentgent.com/wp-content/uploads/2018/03/Awesome-Profile-Pictures-for-Guys-look-away2.jpg"))),
                    SizedBox(width: 15),
                    Expanded(
                        flex: 7,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              keyValue(
                                  key: "Partner number", value: "NIVPART001"),
                              keyValue(key: "Partner Name", value: "Abhishek"),
                              keyValue(key: "Phone", value: "9019301344"),
                            ]))
                  ])),
            ]));
  }

  Widget billDetails() {
    Widget itemValue(
        {@required String key, @required String value, bool bold = false}) {
      return Container(
          padding: EdgeInsets.all(5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$key",
                    style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.black87,
                        fontWeight:
                            bold ? FontWeight.bold : FontWeight.normal)),
                Text("₹ $value",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w600))
              ]));
    }

    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: Colors.grey[500]),
              itemValue(key: "Some good service", value: "100.0"),
              itemValue(key: "Delivery Charges", value: "200.0"),
              itemValue(key: "Tax and Charges", value: "300.0"),
              Divider(color: Colors.grey[500]),
              itemValue(key: "Total", value: "600.0"),
            ]));
  }

  Widget serviceTimeAndLocation() {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Scheduled on 14th june 2020 at 5:34",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.black54,
                  )),
              SizedBox(height: 5),
              Text(
                  "342, 12th main JC Nagar Kurubarahalli,Bangalore,Karnataka, Some high court not in supreme court",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  )),
            ]));
  }

  Widget topBar() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 120,
      width: width,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topCenter,
            colors: gradient,
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.arrow_back, color: Colors.black),
            SizedBox(height: 10),
            Container(
                child: Row(children: [
              Container(
                  height: 45,
                  width: 45,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Icon(Icons.home_repair_service,
                          size: 30, color: Colors.black))),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(7),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("NIV0001",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 1,
                          ),
                          Text("Service is Scheduled",
                              style: GoogleFonts.poppins(
                                  fontSize: 12, fontWeight: FontWeight.bold))
                        ])),
              )
            ]))
          ]),
    );
  }
}
