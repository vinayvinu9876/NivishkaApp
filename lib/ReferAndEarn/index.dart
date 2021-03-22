import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class ReferAndEarn extends StatefulWidget {
  @override
  State<ReferAndEarn> createState() => _ReferAndEarn();
}

class _ReferAndEarn extends State<ReferAndEarn> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: blue,
              leading: Icon(Icons.chevron_left, color: Colors.white),
              title: Text("Refer & Earn",
                  style:
                      GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
            ),
            body: Container(
                height: height,
                width: width,
                color: Colors.white,
                child: Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      SizedBox(height: 15),
                      Container(
                          height: 220,
                          width: 220,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(
                                "https://img.freepik.com/free-vector/gift-box-group-happy-people-reward-prize-giveaway-bonus-referral-program-flat-illustration_352905-12.jpg?size=626&ext=jpg"),
                          ))),
                      SizedBox(height: 10),
                      Container(
                          padding: EdgeInsets.only(left: 15, right: 80),
                          child: Text(
                              "Refer your friends and get upto 100 Nivishka Cash",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600))),
                      SizedBox(height: 5),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                              "If your friend or relatives signup you get 100 Nivishka coins for upto 3 Referals. After 3 referals , you will get 70 Nivishka Coins for each singup using your code.",
                              style: GoogleFonts.poppins(
                                  color: Colors.black54, fontSize: 10))),
                      SizedBox(height: 5),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Stack(children: [
                            Container(
                                width: width,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 3.0,
                                      ),
                                    ]),
                                child: Container(
                                    padding: EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.link,
                                            color: Colors.black54,
                                          ),
                                          SizedBox(width: 10),
                                          Text("https://bit.ly/2EmwiSF",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.grey[400],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11))
                                        ]))),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                    width: width * 0.4,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: darkblue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text("Refer Now",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            )))))
                          ])),
                      SizedBox(height: 25),
                      Expanded(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Container(
                                        height: 10,
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                        )),
                                    bottomWidget(
                                        icon: Icons.account_balance_wallet,
                                        title: "My Wallet",
                                        tagline: "Tap to check your earnings"),
                                    Container(
                                        height: 10,
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                        )),
                                    bottomWidget(
                                        icon: Icons.account_balance_wallet,
                                        title: "Refer your organization",
                                        tagline:
                                            "Refer and Earn exciting coins"),
                                  ]))))
                    ])))));
  }

  Widget bottomWidget(
      {@required IconData icon,
      @required String title,
      @required String tagline}) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        height: 70,
        width: width,
        padding: EdgeInsets.all(15),
        child: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Icon(icon, color: Colors.grey[500]),
              SizedBox(width: 15),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$title",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        )),
                    Text("$tagline",
                        style: GoogleFonts.poppins(
                            fontSize: 10, color: Colors.grey[400]))
                  ]),
              Expanded(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                      )))
            ])));
  }
}
