import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import "WalletModel.dart";
import 'package:provider/provider.dart';

class Wallet extends StatefulWidget {
  @override
  State<Wallet> createState() => _Wallet();
}

class _Wallet extends State<Wallet> {
  @override
  void initState() {
    super.initState();
    var walletModel = Provider.of<WalletModel>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => walletModel.getWalletData());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var walletModel = Provider.of<WalletModel>(context, listen: false);
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            bottomNavigationBar: CustomBottomNavBar(selectedIndex: 2),
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
                            SizedBox(height: 5),
                            for (DateTime key
                                in walletModel.dividedTransactionsData.keys)
                              transactionList(
                                  key, walletModel.dividedTransactionsData[key])
                          ]))
                ]))));
  }

  Widget transactionList(DateTime date, List<Map<String, dynamic>> dataList) {
    DateTime today = new DateTime.now();
    String label = "";

    if (today.difference(date).compareTo(Duration(days: 1)) <
        0) //return negative if shorter
      label = "Today";
    else if (today.difference(date).compareTo(Duration(days: 2)) < 0)
      label = "Yesterday";
    else
      label = "${date.day}-${date.month}-${date.year}";

    return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$label",
                  style:
                      GoogleFonts.poppins(color: Colors.black, fontSize: 12)),
              SizedBox(height: 5),
              for (Map<String, dynamic> trans in dataList)
                transaction(
                    imgUrl:
                        "https://m.economictimes.com/thumb/msid-57371236,width-1200,height-900,resizemode-4,imgsize-9448/paytm-wallet-reaches-200-million-users.jpg",
                    title: "Top Up using ${trans["payment_method"]}",
                    time:
                        "${trans["createDate"].toDate().hour.toString() + " : " + trans["createDate"].toDate().minute.toString()}",
                    isPositive: true,
                    cost: "${trans["payment_amount"] / 100}"),
            ]));
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
    var walletModel = Provider.of<WalletModel>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
        child: Stack(children: [
      Container(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
          child: Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20)))),
      Container(
          padding: EdgeInsets.only(top: 20, left: 45, right: 45, bottom: 5),
          child: Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20)))),
      Container(
          height: 150,
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
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back, color: Colors.white))),
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
                                Text(
                                    "₹ ${walletModel.walletData == null ? "NA" : walletModel.walletData["wallet_balance"] / 100}",
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
              ]))),
    ]));
  }
}
