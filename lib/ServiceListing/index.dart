import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:nivishka_android/util/index.dart';

class ServiceListing extends StatefulWidget {
  @override
  State<ServiceListing> createState() => _ServiceListing();
}

class _ServiceListing extends State<ServiceListing> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        child: Scaffold(
            bottomNavigationBar: checkoutButton(),
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
                elevation: 4,
                backgroundColor: Colors.white,
                centerTitle: true,
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
                title: Text("Plumbers and Repairs",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                    ))),
            body: Container(
                height: height,
                width: width,
                child: ListView(children: [
                  categoryList(),
                  SizedBox(height: 10),
                  Container(
                      width: width,
                      padding: EdgeInsets.all(10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Basin & Sink",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 10),
                            item(
                                name: "Waste Pipe",
                                imgUrl:
                                    "https://res.cloudinary.com/urbanclap/image/upload/t_medium_res_template,q_30/categories/category_v2/category_a15b16e0.jpeg",
                                rating: "4.5",
                                noOfRatings: "14.5k",
                                cost: "119",
                                bulletPoints: [
                                  "Best Suited for installation Leakage",
                                  "Best Suited for installation Leakage",
                                ]),
                            SizedBox(height: 10),
                            item(
                                name: "Washbasin Repair",
                                imgUrl:
                                    "https://res.cloudinary.com/urbanclap/image/upload/t_medium_res_template,q_30/categories/category_v2/category_a7bc5bd0.jpeg",
                                rating: "4.72",
                                noOfRatings: "8.7k",
                                cost: "169  ",
                                bulletPoints: [
                                  "Suitable for leakage under basin",
                                  "Any one of coupling or bottle trap repair",
                                  "Any one of coupling or bottle trap repair"
                                ]),
                          ])),
                  SizedBox(height: 10),
                  Container(
                      width: width,
                      padding: EdgeInsets.all(10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Bath Fitting",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 10),
                            item(
                                name: "Bath Fitting Installation",
                                imgUrl:
                                    "https://res.cloudinary.com/urbanclap/image/upload/t_medium_res_template,q_30/images/supply/customer-app-supply/1597927820534-5be4b1.png",
                                rating: "4.74",
                                noOfRatings: "1.9k",
                                cost: "100",
                                bulletPoints: [
                                  "Any one tap or holder",
                                ]),
                            SizedBox(height: 10),
                            item(
                                name: "Shower Installation Ceiling Mounted",
                                imgUrl:
                                    "https://res.cloudinary.com/urbanclap/image/upload/t_medium_res_template,q_30/categories/category_v2/category_4f7dff40.png",
                                rating: "4.72",
                                noOfRatings: "1.7k",
                                cost: "139  ",
                                bulletPoints: []),
                          ])),
                ]))));
  }

  Widget checkoutButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ]),
        padding: EdgeInsets.all(15),
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/receipt");
            },
            child: Container(
                height: 50,
                padding:
                    EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.green[800],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 2, bottom: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                ),
                                child: Text("1",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ))),
                            SizedBox(width: 10),
                            Text("₹ 119",
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                ))
                          ])),
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text("Continue",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.white,
                                )),
                            Icon(Icons.keyboard_arrow_right,
                                color: Colors.white)
                          ]))
                    ]))));
  }

  Widget item({
    @required String name,
    @required String imgUrl,
    @required String rating,
    @required String noOfRatings,
    @required String cost,
    @required List<String> bulletPoints,
  }) {
    return Card(
        elevation: 0,
        child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage("$imgUrl"))))),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 5,
                          child: Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text("$name",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Color(0xFF252525),
                                      fontWeight: FontWeight.w500,
                                    )),
                                SizedBox(height: 5),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.green[800],
                                      ),
                                      SizedBox(width: 3),
                                      Text("$rating",
                                          style: GoogleFonts.poppins(
                                              color: Colors.green[800],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                      SizedBox(width: 5),
                                      Text("$noOfRatings ratings",
                                          style: GoogleFonts.poppins(
                                              color: Colors.grey[500],
                                              fontSize: 10))
                                    ]),
                                SizedBox(height: 3),
                                Text("₹ $cost",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black, fontSize: 12))
                              ])),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                              child: Container(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                SizedBox(height: 15),
                                counter(),
                              ]))),
                        )
                      ]),
                  SizedBox(height: 15),
                  Visibility(
                      visible: bulletPoints.length > 0,
                      child: Container(height: 1, color: Colors.grey[100])),
                  Visibility(
                      visible: bulletPoints.length > 0,
                      child: SizedBox(height: 10)),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (String i in bulletPoints)
                          Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Bullet("$i",
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[500],
                                    fontSize: 10,
                                  ))),
                      ])
                ])));
  }

  Widget counter() {
    return Container(
        width: 87,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Colors.green),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                  ),
                  child: Center(
                      child: Text("-",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                          )))),
              Container(
                  width: 25,
                  color: Colors.white,
                  child: Center(
                      child: Text(" 0 ",
                          style: GoogleFonts.poppins(
                              color: Colors.green[800], fontSize: 10)))),
              Container(
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.green[600],
                  ),
                  child: Center(
                      child: Text("+",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                          )))),
            ]));
  }

  Widget categoryList() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: ListView(scrollDirection: Axis.horizontal, children: [
          categoryListWidget(
            name: "Basin and Sink",
          ),
          categoryListWidget(
            name: "Bath Fitting",
            active: true,
          ),
          categoryListWidget(
            name: "Blockage",
          ),
          categoryListWidget(
            name: "Tap & Mixer",
          ),
          categoryListWidget(
            name: "Toilet",
          ),
          categoryListWidget(
            name: "Water Tank",
          ),
          categoryListWidget(
            name: "Motor",
          ),
          categoryListWidget(
            name: "Minor Installation",
          ),
          categoryListWidget(
            name: "Looking for Something Else ?",
          ),
        ]));
  }

  Widget categoryListWidget({@required String name, bool active = false}) {
    return Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: active ? Colors.green[600] : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(width: 1, color: active ? primaryColor : Colors.black),
        ),
        padding: EdgeInsets.all(10),
        child: Text("$name",
            style: GoogleFonts.poppins(
                color: active ? Colors.white : Colors.black, fontSize: 12)));
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
          '•   ${data}',
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
