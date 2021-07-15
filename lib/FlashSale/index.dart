import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:styled_text/styled_text.dart';

class FlashSale extends StatefulWidget {
  @override
  State<FlashSale> createState() => _FlashSale();
}

class _FlashSale extends State<FlashSale> {
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
                child: Stack(children: [
                  Container(
                      height: height * 0.4,
                      width: width,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomLeft,
                            colors: gradient,
                          ),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.elliptical(150, 95))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      "/home", (Route<dynamic> route) => false);
                                },
                                child: Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                )),
                            SizedBox(height: 10),
                            Text("Flash Sale",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  letterSpacing: 1.0,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 5),
                            StyledText(
                                text:
                                    "<text>End Time   <b>01 : 30 : 59</b></text>",
                                styles: {
                                  "text": GoogleFonts.poppins(
                                      letterSpacing: 1.0,
                                      color: Colors.white,
                                      fontSize: 12),
                                  "b": GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600)
                                })
                          ])),
                  Container(
                      margin: EdgeInsets.only(
                        top: 110,
                      ),
                      padding: EdgeInsets.all(15),
                      child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                              height: height * 0.8,
                              width: width,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        height: 150,
                                        width: width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Stack(children: [
                                          Container(
                                              height: 150,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(15)),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRKd6TjSvpyiaqaPIpUVe_V1sBmvFdGeCRJQ&usqp=CAU")),
                                              )),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                  height: 30,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green[100],
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(15),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      20))),
                                                  child: Center(
                                                      child: Text("-27%",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 8,
                                                            color: Colors
                                                                .green[800],
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )))))
                                        ])),
                                    Expanded(
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                              Text(
                                                                  "Beauty Enhancer Package",
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          10)),
                                                              SizedBox(
                                                                  height: 10),
                                                              StyledText(
                                                                  text:
                                                                      "<all>Sold <b>150</b> out of <b>180</b></all>",
                                                                  styles: {
                                                                    "b": GoogleFonts.poppins(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                    "all": GoogleFonts
                                                                        .poppins(
                                                                            fontSize:
                                                                                10)
                                                                  }),
                                                            ])),
                                                        Container(
                                                            child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                              Text("Details",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              blue)),
                                                              SizedBox(
                                                                  height: 5),
                                                              Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Container(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                2,
                                                                            bottom:
                                                                                2,
                                                                            left:
                                                                                5,
                                                                            right:
                                                                                5),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border: Border.all(
                                                                              width: 0.2,
                                                                              color: Colors.grey),
                                                                        ),
                                                                        child: Text(
                                                                            "-",
                                                                            style:
                                                                                GoogleFonts.poppins(fontSize: 8))),
                                                                    SizedBox(
                                                                        width:
                                                                            5),
                                                                    Container(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                2,
                                                                            bottom:
                                                                                2,
                                                                            left:
                                                                                5,
                                                                            right:
                                                                                5),
                                                                        child: Text(
                                                                            "1",
                                                                            style:
                                                                                GoogleFonts.poppins(fontSize: 8, color: blue))),
                                                                    SizedBox(
                                                                        width:
                                                                            5),
                                                                    Container(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                2,
                                                                            bottom:
                                                                                2,
                                                                            left:
                                                                                5,
                                                                            right:
                                                                                5),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          border: Border.all(
                                                                              width: 0.2,
                                                                              color: Colors.grey),
                                                                        ),
                                                                        child: Text(
                                                                            "+",
                                                                            style:
                                                                                GoogleFonts.poppins(color: Colors.black, fontSize: 8))),
                                                                  ]),
                                                              SizedBox(
                                                                  height: 15),
                                                            ])),
                                                      ]),
                                                  Expanded(
                                                      child: Container(
                                                          child: ListView(
                                                              children: [
                                                        Bullet(
                                                            "STANDALONE state of the art beauty products: Stow way the services,expensive products,and services. and just experience the virtual reality",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize: 8,
                                                                    color: Colors
                                                                        .grey)),
                                                        SizedBox(height: 10),
                                                        Bullet(
                                                            "STANDALONE state of the art beauty products: Stow way the services,expensive products,and services. and just experience the virtual reality",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize: 8,
                                                                    color: Colors
                                                                        .grey)),
                                                        SizedBox(height: 10),
                                                        Bullet(
                                                            "STANDALONE state of the art beauty products: Stow way the services,expensive products,and services. and just experience the virtual reality",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize: 8,
                                                                    color: Colors
                                                                        .grey)),
                                                        SizedBox(height: 10),
                                                        Bullet(
                                                            "STANDALONE state of the art beauty products: Stow way the services,expensive products,and services. and just experience the virtual reality",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize: 8,
                                                                    color: Colors
                                                                        .grey)),
                                                        SizedBox(height: 10),
                                                        Bullet(
                                                            "STANDALONE state of the art beauty products: Stow way the services,expensive products,and services. and just experience the virtual reality",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize: 8,
                                                                    color: Colors
                                                                        .grey)),
                                                        SizedBox(height: 10),
                                                        Bullet(
                                                            "STANDALONE state of the art beauty products: Stow way the services,expensive products,and services. and just experience the virtual reality",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize: 8,
                                                                    color: Colors
                                                                        .grey)),
                                                        SizedBox(height: 10),
                                                        Bullet(
                                                            "STANDALONE state of the art beauty products: Stow way the services,expensive products,and services. and just experience the virtual reality",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize: 8,
                                                                    color: Colors
                                                                        .grey)),
                                                        SizedBox(height: 10),
                                                      ]))),
                                                  Container(
                                                      padding:
                                                          EdgeInsets.all(15),
                                                      child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text("\$ 104",
                                                                style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            Container(
                                                                height: 30,
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(
                                                                  left: 10,
                                                                  right: 10,
                                                                  top: 5,
                                                                  bottom: 5,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .green[
                                                                      500],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                ),
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                          Icons
                                                                              .shopping_bag,
                                                                          color: Colors
                                                                              .white,
                                                                          size:
                                                                              18),
                                                                      SizedBox(
                                                                          width:
                                                                              6),
                                                                      Text(
                                                                          "Buy Now",
                                                                          style: GoogleFonts.poppins(
                                                                              fontSize: 10,
                                                                              color: Colors.white))
                                                                    ]))
                                                          ]))
                                                ])))
                                  ]))))
                ]))));
  }
}

class Bullet extends Text {
  const Bullet(
    String data, {
    Key key,
    TextStyle style,
    TextAlign textAlign,
    TextDirection textDirection,
    Locale locale,
    bool softWrap,
    TextOverflow overflow,
    double textScaleFactor,
    int maxLines,
    String semanticsLabel,
  }) : super(
          '• ${data}',
          key: key,
          style: style,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
        );
}
