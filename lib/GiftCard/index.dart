import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class GiftCard extends StatefulWidget {
  @override
  State<GiftCard> createState() => _GiftCard();
}

class _GiftCard extends State<GiftCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            body: Container(
                color: Colors.grey[200],
                child: Stack(children: [
                  Container(
                      height: height * 0.5,
                      width: width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3.0,
                            ),
                          ],
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter,
                            colors: gradient,
                          ))),
                  Container(
                      height: height,
                      width: width,
                      padding: EdgeInsets.all(10),
                      child: ListView(children: [
                        Container(
                            height: 50,
                            width: width,
                            child: Row(children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        "/home",
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Icon(Icons.chevron_left,
                                      color: Colors.white)),
                              Expanded(
                                  child: Center(
                                      child: Text("Gift Cards",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold))))
                            ])),
                        SizedBox(height: 15),
                        Container(
                            height: 100,
                            width: width,
                            padding: EdgeInsets.all(10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("₹ 1,000",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                  Text("Total Gift Money",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.white.withOpacity(0.9)))
                                ])),
                        coupon(
                            imgUrl:
                                "https://cdn.mos.cms.futurecdn.net/xDGQ9dbLmMpeEqhiWayMRB.jpg",
                            desc:
                                "Gift Card valued at \$50 or 10% off at Mc.Donalds",
                            expireDate: "04 Jan 2021",
                            value: "100"),
                        coupon(
                            imgUrl:
                                "https://i.pinimg.com/600x315/24/00/79/240079ae6ed9ddb6309ac63785695f93.jpg",
                            desc:
                                "Gifted to you by Vinay P using his email id vinayrasal7@gmail.com",
                            expireDate: "06 Feb 2021",
                            value: "200"),
                        coupon(
                            imgUrl:
                                "https://cdn.mos.cms.futurecdn.net/xDGQ9dbLmMpeEqhiWayMRB.jpg",
                            desc:
                                "Gift Card valued at \$50 or 10% off at Mc.Donalds",
                            expireDate: "04 Jan 2021",
                            value: "100"),
                        coupon(
                            imgUrl:
                                "https://i.pinimg.com/600x315/24/00/79/240079ae6ed9ddb6309ac63785695f93.jpg",
                            desc:
                                "Gifted to you by Vinay P using his email id vinayrasal7@gmail.com",
                            expireDate: "06 Feb 2021",
                            value: "200"),
                        SizedBox(height: 20),
                      ])),
                ]))));
  }

  Widget coupon(
      {@required String imgUrl,
      @required String desc,
      @required String expireDate,
      @required String value}) {
    double width = MediaQuery.of(context).size.width;

    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/voucherCode");
        },
        child: Container(
            margin: EdgeInsets.only(top: 5, bottom: 5),
            child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(10)),
                              ),
                              child: Row(children: [
                                CircleAvatar(
                                    backgroundImage: NetworkImage("$imgUrl")),
                                SizedBox(width: 10),
                                Expanded(
                                    child: Text("$desc",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 12)))
                              ])),
                          Container(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                          Text("Expires",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 10,
                                                  color: Colors.grey[500])),
                                          Text("$expireDate",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(height: 5),
                                          Text("Terms & Condition Apply",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  color: blue,
                                                  fontSize: 8))
                                        ])),
                                    Container(
                                        height: 30,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomCenter,
                                              colors: gradient,
                                            )),
                                        child: Center(
                                            child: Text("₹ $value",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white))))
                                  ]))
                        ])))));
  }
}
