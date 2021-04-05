import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import "Colors.dart";

class CustomBottomNavBar extends StatefulWidget {
  CustomBottomNavBar({this.selectedIndex});
  final int selectedIndex;
  @override
  State<CustomBottomNavBar> createState() =>
      _CustomBottomNavBar(selectedIndex: selectedIndex);
}

class _CustomBottomNavBar extends State<CustomBottomNavBar> {
  _CustomBottomNavBar({this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
      ]),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
              rippleColor: Colors.grey[300],
              hoverColor: blue,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.green[600].withOpacity(0.9),
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.access_time_rounded,
                  text: 'History',
                ),
                GButton(
                  icon: Icons.account_balance_wallet,
                  text: 'Wallet',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                if (selectedIndex == index) {
                  return;
                }
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, "/home");
                    break;
                  case 1:
                    Navigator.pushNamed(context, "/bookingHistory");
                    break;
                  case 2:
                    Navigator.pushNamed(context, "/wallet");
                    break;
                  case 3:
                    Navigator.pushNamed(context, "/profile");
                    break;
                }
              }),
        ),
      ),
    );
  }
}
