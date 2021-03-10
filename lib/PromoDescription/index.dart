import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class PromoDescription extends StatefulWidget {
  @override
  State<PromoDescription> createState() => _PromoDescription();
}

class _PromoDescription extends State<PromoDescription> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Promo Details",
              style: GoogleFonts.poppins(
                fontSize: 12,
              )),
        ),
        body: Container(
            height: height,
            width: width,
            child: ListView(children: [
              Container(
                height: 200,
                width: width,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "https://images.ctfassets.net/hrltx12pl8hq/5HquLfhnUXsQqTYzgJ6V0H/a4e1e1dfab9b5d0197a81db2b91b37ca/Artboard_59.png?fit=fill&w=480&h=268"))),
              ),
              Container(
                  padding:
                      EdgeInsets.only(top: 15, left: 15, right: 10, bottom: 5),
                  child: Text(
                      "Flat Rs.25 cashback on your Recharges or Bill Payments",
                      style: GoogleFonts.poppins(fontSize: 12))),
              Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),
                  child: Text("#APPLYTHISPROMONOW",
                      style: GoogleFonts.poppins(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14))),
              Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 5),
                  child: Text("Offer Details",
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w600))),
              Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Bullet(
                            "Get Flat Rs.25 cashback on your first Recharge or Bill Payment of month on Mobikwik App",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 10)),
                        SizedBox(height: 10),
                        Bullet(
                            "Minimum amount spent to avail the offer is Rs.100",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 10)),
                        SizedBox(height: 10),
                        Bullet("KYC Users are eligible for Cashback benefits",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 10)),
                        SizedBox(height: 10),
                        Bullet(
                            "Coupon Redemption and Payment should be done on Android & IOS app",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 10)),
                        SizedBox(height: 10),
                        Bullet(
                            "The offer is applicable on the first transaction of the month and valid for all operators.",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 10)),
                        SizedBox(height: 10),
                        Bullet(
                            "The code can be redeemed only once per user per month.",
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 10))
                      ])),
              SizedBox(height: 20),
              Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                            elevation: 2,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: blue,
                                ),
                                padding: EdgeInsets.all(10),
                                child: Text("Claim Now",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 10))))
                      ]))
            ])));
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
