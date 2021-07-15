import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:provider/provider.dart';
import 'package:nivishka_android/Profile/ProfileModel.dart';
import 'HomeModel.dart';

class CustomDrawer extends StatefulWidget {
  @override
  State<CustomDrawer> createState() => _CustomDrawer();
}

class _CustomDrawer extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    var homeModel = Provider.of<HomeModel>(context);
    var profileModel = Provider.of<ProfileModel>(context);
    return Drawer(
      child: Container(
          padding: EdgeInsets.only(top: 25, bottom: 10, left: 15, right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CircleAvatar(
                  radius: 30, backgroundImage: AssetImage("images/logo.png")),
              SizedBox(height: 20),
              Text(
                  "${homeModel.userData == null ? "Loading..." : homeModel.userData["fname"] + " " + homeModel.userData["lname"]}",
                  style: GoogleFonts.poppins(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              Text(
                  "${homeModel.userData == null ? "Loading..." : homeModel.userData["phone"]}",
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
                          Navigator.pushNamed(context, "/allCategories");
                        }),
                    iconText(
                        icon: Icons.group,
                        text: "Register as Partner",
                        ontap: () {}),
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
              iconText(
                  icon: Icons.logout,
                  text: "Logout",
                  ontap: () {
                    profileModel.logout();
                    Navigator.pushNamedAndRemoveUntil(context, '/splashScreen',
                        (Route<dynamic> route) => false);
                  }),
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
