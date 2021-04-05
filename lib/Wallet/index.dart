import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class Wallet extends StatefulWidget {
  @override
  State<Wallet> createState() => _Wallet();
}

class _Wallet extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            bottomNavigationBar: CustomBottomNavBar(),
            body: Container(
                height: height,
                width: width,
                child: ListView(children: [
                  topBar(),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Today",
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 12)),
                            SizedBox(height: 5),
                            transaction(
                                imgUrl:
                                    "https://m.economictimes.com/thumb/msid-57371236,width-1200,height-900,resizemode-4,imgsize-9448/paytm-wallet-reaches-200-million-users.jpg",
                                title: "Top up using PayTM Wallet",
                                time: "10:43 AM",
                                isPositive: true,
                                cost: "500"),
                            transaction(
                                imgUrl:
                                    "https://images.livemint.com/img/2020/05/13/600x338/knowledge_graph_logo_1558085837429_1589341700472.png",
                                title: "Paid using Google UPI",
                                time: "12:43 AM",
                                isPositive: true,
                                cost: "900"),
                            transaction(
                                imgUrl:
                                    "https://previews.123rf.com/images/alexutemov/alexutemov1509/alexutemov150900193/44961051-n-letter-vector-n-logo-icon-template-n-symbol-silhouette-n-isolated-icon-n-line-style-letter-n-logot.jpg",
                                title: "Paid for Hair Wash services",
                                time: "1:43 AM",
                                isPositive: false,
                                cost: "600"),
                            SizedBox(height: 10),
                            Text("Yesterday",
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 12)),
                            SizedBox(height: 5),
                            transaction(
                                imgUrl:
                                    "https://m.economictimes.com/thumb/msid-57371236,width-1200,height-900,resizemode-4,imgsize-9448/paytm-wallet-reaches-200-million-users.jpg",
                                title: "Top up using PayTM Wallet",
                                time: "10:43 AM",
                                isPositive: true,
                                cost: "500"),
                            SizedBox(height: 20),
                          ]))
                ]))));
  }

  Widget transaction(
      {@required String imgUrl,
      @required String title,
      @required String time,
      @required bool isPositive,
      @required String cost}) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey[200],
                )),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage("$imgUrl"))))),
                  SizedBox(width: 20),
                  Expanded(
                      flex: 6,
                      child: Container(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text("$title",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10)),
                            Text("$time",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ))
                          ]))),
                  Expanded(
                      flex: 2,
                      child: Container(
                          child: Center(
                              child: Text("${isPositive ? "+" : "-"} ₹ $cost",
                                  style: GoogleFonts.poppins(
                                      color: isPositive
                                          ? Colors.greenAccent[700]
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)))))
                ])));
  }

  Widget topBar() {
    double width = MediaQuery.of(context).size.width;
    return Container(
        child: Stack(children: [
      Container(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
          child: Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20)))),
      Container(
          padding: EdgeInsets.only(top: 20, left: 45, right: 45, bottom: 5),
          child: Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20)))),
      Container(
          height: 200,
          width: width,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.green[600],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                    child: Row(children: [
                  Expanded(
                      flex: 1,
                      child: Icon(Icons.arrow_back, color: Colors.white)),
                  Expanded(
                      flex: 8,
                      child: Center(
                          child: Text("Wallet",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)))),
                  Expanded(flex: 1, child: Container())
                ])),
                SizedBox(height: 25),
                Container(
                    width: width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text("My Wallet Balance",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text("₹ 2,500.30",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ])),
                          InkWell(
                              onTap: () => {
                                    Navigator.pushNamed(context, "/topupwallet")
                                  },
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFffb84d),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, bottom: 7, top: 7),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            child: Center(
                                                child: Text("Top-up",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10,
                                                        color: Colors.white)))),
                                      ])))
                        ])),
                SizedBox(height: 25),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.green[500],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Gift a Card",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              )),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: Colors.white,
                          )
                        ]))
              ]))),
    ]));
  }
}
