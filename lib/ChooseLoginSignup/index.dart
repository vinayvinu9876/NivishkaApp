import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class ChooseLoginSignup extends StatefulWidget {
  @override
  State<ChooseLoginSignup> createState() => _ChooseLoginSignup();
}

class _ChooseLoginSignup extends State<ChooseLoginSignup> {
  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => SystemChannels.platform
                    .invokeMethod<void>('SystemNavigator.pop'),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
            top: true,
            bottom: true,
            child: Scaffold(
                body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.black, Colors.black],
              )),
              height: height,
              child: Column(
                children: [
                  Expanded(
                      flex: 6,
                      child: Container(
                          height: height * 0.3,
                          width: width,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  height: 140,
                                  width: 140,
                                  image: AssetImage("images/logo2.png"),
                                ),
                                //Image(
                                //height: 100,
                                //image: AssetImage("images/logo1.jpeg")),
                                SizedBox(height: 10),
                                /*Text("Nivishka",
                                style: GoogleFonts.dancingScript(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 5),
                            Text("Making it Easy",
                                style: GoogleFonts.poppins(
                                    color: Colors.white60, fontSize: 12)),*/
                              ]))),
                  Expanded(
                      flex: 4,
                      child: Container(
                          width: width,
                          padding: EdgeInsets.all(15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                shadowButton(
                                    height: 40,
                                    width: width * 0.6,
                                    color: Colors.white70,
                                    shadowColor: Colors.grey,
                                    text: "Sign Up",
                                    fontSize: 14,
                                    fontColor: Colors.green[800],
                                    fontWeight: FontWeight.bold,
                                    ontap: () {
                                      Navigator.pushNamed(context, "/signup");
                                    }),
                                SizedBox(height: 20),
                                Text("Already have a Nivishka Account ?",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white54, fontSize: 10)),
                                SizedBox(height: 20),
                                gradientButton(
                                  height: 40,
                                  width: width * 0.6,
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.bottomLeft,
                                    colors: [primaryColor, Colors.green],
                                  ),
                                  border: Border.all(
                                      color: Colors.white30, width: 1.0),
                                  text: "Login",
                                  fontSize: 14,
                                  fontColor: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  ontap: () => {
                                    Navigator.pushNamed(context, "/enterPhone")
                                  },
                                ),
                              ])))
                ],
              ),
            ))));
  }
}
