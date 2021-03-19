import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class SelectOtherLocation extends StatefulWidget {
  @override
  State<SelectOtherLocation> createState() => _SelectOtherLocation();
}

class _SelectOtherLocation extends State<SelectOtherLocation> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            appBar: AppBar(
                title: Container(
                    child: Container(
                        height: 60,
                        child: TextField(
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                                hintText:
                                    "Search for society,landmark,locality etc",
                                hintStyle: GoogleFonts.poppins(
                                    color: Colors.white54, fontSize: 10),
                                suffixIcon: Icon(Icons.clear,
                                    color: Colors.white54, size: 12),
                                contentPadding: EdgeInsets.only(
                                    left: 5, top: 15, bottom: 0),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white54)),
                                disabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white54)),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white54))))))),
            body: Container(
                height: height,
                width: width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/selectLocation");
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey[500], width: 0.3),
                                  )),
                              padding: EdgeInsets.all(15),
                              child: Row(children: [
                                Icon(Icons.gps_fixed, color: blue),
                                SizedBox(width: 15),
                                Text("Use Current Location",
                                    style: GoogleFonts.poppins(
                                        color: blue, fontSize: 12))
                              ]))),
                      Expanded(
                        child: Container(
                            child: ListView(children: [
                          Container(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        child: Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                    )),
                                    SizedBox(width: 15),
                                    Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200])),
                                        ),
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Kanti Power Solutions",
                                                  style: GoogleFonts.poppins()),
                                              SizedBox(height: 5),
                                              Container(
                                                  width: width - 69,
                                                  child: Text(
                                                      "JC Nagar, kurubarahalli,Basaveshwara Nagar, Bengaluru,Karnataka ,India",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: Colors
                                                                  .grey[400],
                                                              fontSize: 10))),
                                            ]))
                                  ]))
                        ])),
                      )
                    ]))));
  }
}
