import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class SendReport extends StatefulWidget {
  @override
  State<SendReport> createState() => _SendReport();
}

class _SendReport extends State<SendReport> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text("Send Report",
                  style:
                      GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
            ),
            body: Container(
                height: height,
                width: width,
                padding: EdgeInsets.all(15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter Details",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 15),
                      Container(
                          child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 10),
                              decoration: InputDecoration(
                                hintText:
                                    "Please Tell us more about your trouble",
                                hintStyle: GoogleFonts.poppins(fontSize: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black)),
                              ))),
                      SizedBox(height: 15),
                      Text("Contact Phone",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 15),
                      TextField(
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 10),
                          decoration: InputDecoration(
                            hintText: "Phone",
                            hintStyle: GoogleFonts.poppins(fontSize: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black)),
                          )),
                      SizedBox(height: 15),
                      ElevatedButton(
                          child: Text("Send Report",
                              style: GoogleFonts.poppins(color: Colors.white)),
                          onPressed: () {
                            print("hello world");
                          }),
                      SizedBox(height: 10),
                      Text("We promise to respond as soon as possible",
                          style: GoogleFonts.poppins(
                            color: Colors.green[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ))
                    ]))));
  }
}
