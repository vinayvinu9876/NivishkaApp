import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawer();
}

class _CustomDrawer extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          padding: EdgeInsets.only(top: 25, bottom: 10, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")),
              SizedBox(height: 20),
              Text("Ana Skulji",
                  style: GoogleFonts.poppins(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              Text("9019301344",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  )),
              SizedBox(height: 10),
              Divider(),
              Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    iconText(
                        icon: Icons.person,
                        text: "Profile",
                        ontap: () {
                          Navigator.pushNamed(context, "/profile");
                        }),
                    iconText(
                        icon: Icons.access_time_rounded,
                        text: "History",
                        ontap: () {
                          Navigator.pushNamed(context, "/bookingHistory");
                        }),
                    iconText(
                        icon: Icons.account_balance_wallet,
                        text: "Wallet",
                        ontap: () {
                          Navigator.pushNamed(context, "/wallet");
                        }),
                    iconText(
                        icon: Icons.list,
                        text: "Categories",
                        ontap: () {
                          Navigator.pushNamed(context, "/categoryDescription");
                        }),
                    iconText(
                        icon: Icons.card_giftcard,
                        text: "Gift Cards",
                        ontap: () {
                          Navigator.pushNamed(context, "/giftCard");
                        }),
                  ])),
              Divider(),
              SizedBox(height: 10),
              iconText(
                  icon: Icons.share,
                  text: "Tell your Friend",
                  ontap: () {
                    Navigator.pushNamed(context, "/referAndEarn");
                  }),
              iconText(
                  icon: Icons.badge,
                  text: "About",
                  ontap: () {
                    Navigator.pushNamed(context, "/about");
                  }),
              Divider(),
              iconText(icon: Icons.logout, text: "Logout"),
            ],
          )),
    );
  }

  Widget iconText(
      {@required IconData icon, @required String text, Function ontap}) {
    return InkWell(
        onTap: ontap,
        child: Container(
            margin: EdgeInsets.only(top: 12, bottom: 12),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Text("$text",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black)),
                ])));
  }
}
