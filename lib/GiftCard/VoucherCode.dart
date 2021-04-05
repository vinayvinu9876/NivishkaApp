import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class VoucherCode extends StatefulWidget {
  @override
  State<VoucherCode> createState() => _VoucherCode();
}

class _VoucherCode extends State<VoucherCode> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            body: Container(
                height: height,
                width: width,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: gradient,
                )),
                child: Center(
                    child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Container(
                            height: 250,
                            width: width * 0.7,
                            padding: EdgeInsets.all(15),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20),
                                  Text("Congragulations !",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.green[800])),
                                  SizedBox(height: 10),
                                  Text(
                                      "Here's the code for your \$50 Domino's Gift Card",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: Colors.black)),
                                  SizedBox(height: 20),
                                  Text("ZP10USE",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(height: 20),
                                  Container(
                                      width: 150,
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomCenter,
                                              colors: gradient)),
                                      child: Center(
                                          child: Text("REDEEM IT",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.white))))
                                ])))))));
  }
}
