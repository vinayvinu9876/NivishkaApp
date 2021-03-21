import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class TopUpWallet extends StatefulWidget {
  @override
  State<TopUpWallet> createState() => _TopUpWallet();
}

class _TopUpWallet extends State<TopUpWallet> {
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
                child: ListView(children: [
                  topBar(),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      child: Center(
                          child: Text("Select an amount to top up",
                              style: GoogleFonts.poppins(
                                color: Colors.black87,
                                fontSize: 12,
                              )))),
                  SizedBox(height: 10),
                  Container(
                      height: 120,
                      width: width,
                      padding: EdgeInsets.all(10),
                      child:
                          ListView(scrollDirection: Axis.horizontal, children: [
                        rechargeAmountSelect(
                          isActive: true,
                          displayNo: 5,
                          cost: 50,
                        ),
                        rechargeAmountSelect(
                          displayNo: 1,
                          cost: 100,
                        ),
                        rechargeAmountSelect(
                          displayNo: 2,
                          cost: 200,
                        ),
                        rechargeAmountSelect(
                          displayNo: 5,
                          cost: 500,
                        ),
                      ])),
                  Container(
                      padding: EdgeInsets.all(15),
                      width: width,
                      child: Center(
                          child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: Center(
                                  child: Text("OR",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey[500])))))),
                  Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Enter other amount",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                )),
                            Container(
                                child: TextField(
                                    decoration: InputDecoration(
                                        hintText: "₹ 0.00",
                                        hintStyle: GoogleFonts.poppins(
                                            color: Colors.grey[400],
                                            fontSize: 18)))),
                            SizedBox(height: 30),
                            Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.orange,
                                    child: Center(
                                        child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ))))
                          ])),
                ]))));
  }

  Widget rechargeAmountSelect(
      {bool isActive = false,
      @required double displayNo,
      @required double cost}) {
    return Container(
        height: 120,
        width: 100,
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 0.8,
                color: isActive ? Colors.orange : Colors.grey[200])),
        child: Stack(children: [
          Container(
              width: 100,
              height: 120,
              padding: EdgeInsets.all(5),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("$displayNo",
                        style: GoogleFonts.poppins(
                            fontSize: 59, color: Colors.grey[100]))
                  ])),
          Container(
              width: 100,
              height: 120,
              padding: EdgeInsets.all(15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        radius: 10,
                        backgroundColor:
                            isActive ? Colors.orange : Colors.black,
                        child: Center(
                          child: isActive
                              ? Icon(Icons.done, size: 14, color: Colors.white)
                              : CircleAvatar(
                                  radius: 9,
                                  backgroundColor: Colors.white,
                                ),
                        )),
                    Text("₹ $cost",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold))
                  ]))
        ]));
  }

  Widget topBar() {
    double width = MediaQuery.of(context).size.width;
    return Container(
        child: Stack(children: [
      Container(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
          child: Container(
              height: 120,
              decoration: BoxDecoration(
                  color: blue.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20)))),
      Container(
          padding: EdgeInsets.only(top: 20, left: 45, right: 45, bottom: 5),
          child: Container(
              height: 120,
              decoration: BoxDecoration(
                  color: blue.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20)))),
      Container(
          height: 120,
          width: width,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: blue,
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
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back, color: Colors.white))),
                  Expanded(
                      flex: 8,
                      child: Center(
                          child: Text("Top up Wallet",
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
                              ])),
                          Text("₹ 2,500.30",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ])),
              ]))),
    ]));
  }
}
