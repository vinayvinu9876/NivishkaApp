import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'package:nivishka_android/SplashScreen/index.dart';
import 'package:nivishka_android/ChooseLoginSignup/index.dart';
import 'package:nivishka_android/Signup/index.dart';
import 'package:nivishka_android/Login/EnterPhone.dart';
import 'package:nivishka_android/OTPScreen/index.dart';
import 'package:nivishka_android/Home/index.dart';

var kReleaseMode = false;

void main() => runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(), // Wrap your app
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/home",
      routes: {
        "/splashScreen": (context) => SplashScreen(),
        "/enterPhone": (context) => EnterPhone(),
        "/chooseLoginSignup": (context) => ChooseLoginSignup(),
        "/signup": (context) => Signup(),
        "/otp_screen": (context) => OTPScreen(),
        "/home": (context) => Home(),
      },
    );
  }
}
