import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ReferAndEarnModel.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:flutter_share/flutter_share.dart';

class ReferAndEarn extends StatefulWidget {
  @override
  State<ReferAndEarn> createState() => _ReferAndEarn();
}

class _ReferAndEarn extends State<ReferAndEarn> {
  @override
  void initState() {
    super.initState();
    var referModel = Provider.of<ReferAndEarnModel>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => referModel.getReferalLimitsData());
  }

  Future<void> share() async {
    var referModel = Provider.of<ReferAndEarnModel>(context, listen: false);
    await FlutterShare.share(
        title: 'Use Nivishka for betterment',
        text:
            'Quick Services that are easy on the wallet, with Nivishka Services. Its always a great service. Try now!. Sign-up on the Nivishka App using my referal code : ${referModel.userData["referalCode"].toString().toUpperCase()} Download the app at ',
        linkUrl: 'https://play.google.com',
        chooserTitle: "Share Nivishka");
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var referModel = Provider.of<ReferAndEarnModel>(context);

    String referalCash = "", newUserCash = "", maxReferals = "";
    String referalCode = "Loading..";

    if (referModel.referalLimitsData != null) {
      referalCash = (referModel.referalLimitsData["referalUserCredit"] / 100)
          .toInt()
          .toString();
      newUserCash = (referModel.referalLimitsData["newUserCredit"] / 100)
          .toInt()
          .toString();
      maxReferals = (referModel.referalLimitsData["maxReferals"]).toString();
    }

    if (referModel.userData != null) {
      referalCode = referModel.userData["referalCode"];
    }

    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green[500],
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.chevron_left, color: Colors.white)),
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
                              "Refer your friends and get $referalCash cash on Nivishka wallet",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600))),
                      SizedBox(height: 5),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                              "If your friend or relatives signup you get $referalCash Nivishka cash for upto $maxReferals Referals. The person you refered will get $newUserCash on their nivishka wallet",
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
                                          Text("$referalCode",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.grey[400],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11))
                                        ]))),
                            Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                    onTap: () {
                                      share();
                                    },
                                    child: Container(
                                        width: width * 0.4,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Color(0xFF296e01),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Center(
                                            child: Text("Refer Now",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ))))))
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
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/wallet");
                                        },
                                        tagline: "Tap to check your earnings"),
                                    Container(
                                        height: 10,
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                        )),
                                    bottomWidget(
                                        icon: Icons.account_balance_wallet,
                                        title: "Top Up Wallet",
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, "/topupwallet");
                                        },
                                        tagline: "Top and win prizes"),
                                  ]))))
                    ])))));
  }

  Widget bottomWidget(
      {@required IconData icon,
      @required String title,
      @required String tagline,
      @required Function onTap}) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: onTap,
        child: Container(
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
                ]))));
  }
}
