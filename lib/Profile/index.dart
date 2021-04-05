import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            bottomNavigationBar: CustomBottomNavBar(),
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.green[600],
                title: Text("My Profile",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ))),
            body: Container(
                height: height,
                width: width,
                child: ListView(children: [
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  width: 0.5, color: Colors.grey[400]))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Vinay P",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 12,
                                )),
                            Text("vvinu9876@gmail.com",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey[600], fontSize: 10)),
                            Text("+91 9019301344",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey[600], fontSize: 10)),
                          ])),
                  Container(height: 10, color: Colors.grey[200]),
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  width: 0.5, color: Colors.grey[400]),
                              bottom: BorderSide(
                                  width: 0.5, color: Colors.grey[400]))),
                      child: Row(children: [
                        Icon(Icons.chat, color: Colors.grey[800]),
                        SizedBox(width: 10),
                        Text("Help Center",
                            style: GoogleFonts.poppins(
                                color: Colors.grey[700],
                                fontSize: 10,
                                fontWeight: FontWeight.w600))
                      ])),
                  Container(height: 10, color: Colors.grey[200]),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                top: BorderSide(
                                    width: 0.5, color: Colors.grey[400]),
                              )),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                iconText(
                                    icon: Icons.how_to_reg,
                                    text: "Register as Partner"),
                                iconText(
                                    icon: Icons.badge,
                                    text: "About Nivishka Services"),
                                iconText(
                                    icon: Icons.share,
                                    text: "Share Nivishka App"),
                                iconText(
                                    icon: Icons.loyalty,
                                    text: "Refer and Earn",
                                    ontap: () => Navigator.pushNamed(
                                        context, "/referAndEarn")),
                                iconText(
                                    icon: Icons.card_giftcard,
                                    text: "My Gift Cards"),
                                iconText(
                                    icon: Icons.account_balance_wallet,
                                    text: "My Wallet",
                                    ontap: () => Navigator.pushNamed(
                                        context, "/wallet")),
                                iconText(
                                    icon: Icons.schedule,
                                    text: "Scheduled Booking"),
                                iconText(
                                    icon: Icons.star, text: "Rate Nivishka"),
                                iconText(icon: Icons.build, text: "Settings"),
                              ]))),
                  SizedBox(height: 10),
                  Container(
                      child: Center(
                          child: Text("Logout",
                              style: GoogleFonts.poppins(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              )))),
                  SizedBox(height: 15),
                ]))));
  }

  Widget iconText(
      {@required IconData icon, @required String text, Function ontap}) {
    return InkWell(
        onTap: ontap,
        child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.grey[300]))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(icon, size: 20, color: Colors.black38),
                  SizedBox(width: 10),
                  Text("$text",
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ))
                ])));
  }
}
