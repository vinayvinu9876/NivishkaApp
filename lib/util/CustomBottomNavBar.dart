import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import "Colors.dart";

class CustomBottomNavBar extends StatefulWidget {
  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBar();
}

class _CustomBottomNavBar extends State<CustomBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 1;
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
                  icon: Icons.ac_unit,
                  text: 'Likes',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.access_time_rounded,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  print("Selected Index = $index");
                  _selectedIndex = index;
                });
              }),
        ),
      ),
    );
  }
}
