import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class Receipt extends StatefulWidget {
  @override
  State<Receipt> createState() => _Receipt();
}

class _Receipt extends State<Receipt> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: checkoutButton(),
            appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                elevation: 3,
                leading: Icon(Icons.arrow_back, color: Colors.black, size: 16),
                title: Text("Plumbers",
                    style: GoogleFonts.poppins(
                        color: Colors.black, fontSize: 14))),
            body: Container(
                height: height,
                width: width,
                child: ListView(children: [
                  Container(
                      child: Column(children: [
                    itemPrice(
                        name: "Waste Pipe",
                        price: "369",
                        strikedprice: "469",
                        bulletList: [
                          "Best suited for Installation and Leakage"
                        ]),
                    Container(
                        padding: EdgeInsets.only(
                            top: 5, bottom: 5, left: 15, right: 15),
                        child: Container(
                          height: 1,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                        )),
                    itemPrice(
                        name: "Washbasin Repair",
                        price: "169",
                        strikedprice: "169",
                        bulletList: [
                          "Suitable for leakage under basin",
                          "Any one of coupling or bottle trap repair",
                          "Any one of coupling or bottle trap repair"
                        ]),
                  ])),
                  Container(height: 15, color: Colors.grey[100]),
                  Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              width: 1, color: Colors.black)),
                                      child: Center(
                                          child: Text("%",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16)))),
                                  SizedBox(width: 10),
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "Offers, promo code and gift cards",
                                            style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 10,
                                            )),
                                        Text("4 offers available",
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey[400],
                                                fontSize: 10))
                                      ])
                                ])),
                            Container(
                                child: Icon(Icons.chevron_right,
                                    color: Colors.grey[600]))
                          ])),
                  Container(height: 15, color: Colors.grey[100]),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            itemPriceList(name: "Item Total", price: "288"),
                            itemPriceList(
                                name: "Convenience & other charges [+]",
                                price: "99"),
                            SizedBox(height: 10),
                            Container(
                              height: 2,
                              width: width,
                              color: Colors.grey[100],
                            ),
                            itemPriceList(
                                name: "Total", price: "387", isTotal: true),
                          ]))
                ]))));
  }

  Widget checkoutButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey,
          ),
        ]),
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/serviceLocationSelect");
            },
            child: Container(
                height: 50,
                padding:
                    EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.green[800],
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
                            SizedBox(width: 10),
                            Text("₹ 387",
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                ))
                          ])),
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text("Pay Now",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.white,
                                )),
                            Icon(Icons.keyboard_arrow_right,
                                color: Colors.white)
                          ]))
                    ]))));
  }

  Widget itemPriceList(
      {@required String name, @required String price, bool isTotal = false}) {
    FontWeight weight = isTotal ? FontWeight.bold : FontWeight.normal;
    double fontSize = isTotal ? 12 : 10;
    Color color = isTotal ? Colors.black : Colors.grey[600];
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("$name",
                  style: GoogleFonts.poppins(
                      color: color, fontSize: fontSize, fontWeight: weight)),
              Text("₹ $price",
                  style: GoogleFonts.roboto(
                      color: color, fontSize: fontSize, fontWeight: weight))
            ]));
  }

  Widget itemPrice(
      {@required name,
      @required price,
      @required strikedprice,
      @required List<String> bulletList}) {
    return Container(
        padding: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$name",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(height: 5),
                    Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          for (String i in bulletList)
                            Bullet("$i",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[500],
                                  fontSize: 10,
                                )),
                        ]))
                  ]),
              SizedBox(height: 15),
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            child: Row(children: [
                          Text("₹$price",
                              style: GoogleFonts.roboto(
                                  color: Colors.black, fontSize: 12)),
                          SizedBox(width: 5),
                          Text("₹$strikedprice",
                              style: GoogleFonts.roboto(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey[500],
                                  fontSize: 10))
                        ]))),
                    Container(
                      width: 80,
                      child: counter(),
                    )
                  ]))
            ]));
  }

  Widget counter() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Colors.green[800]),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[800],
                      ),
                      child: Center(
                          child: Text("-",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                              ))))),
              Expanded(
                  flex: 1,
                  child: Container(
                      color: Colors.white,
                      child: Center(
                          child: Text(" 0 ",
                              style: GoogleFonts.poppins(
                                  color: Colors.green, fontSize: 10))))),
              Expanded(
                  flex: 1,
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[800],
                      ),
                      child: Center(
                          child: Text("+",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                              ))))),
            ]));
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
