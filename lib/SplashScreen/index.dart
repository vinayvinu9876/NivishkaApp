import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  final threeSec = const Duration(seconds: 3);

  @override
  void initState() {
    super.initState();
    new Timer.periodic(threeSec, (Timer t) {
      Navigator.pushNamed(context, "/chooseLoginSignup");
      t.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
          height: height,
          width: width,
          color: Colors.black,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(height: 150, image: AssetImage("images/logo2.png")),
              ])),
    );
  }
}
