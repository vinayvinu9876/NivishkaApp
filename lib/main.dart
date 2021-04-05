import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

import 'package:nivishka_android/SplashScreen/index.dart';
import 'package:nivishka_android/ChooseLoginSignup/index.dart';
import 'package:nivishka_android/Signup/index.dart';
import 'package:nivishka_android/Login/EnterPhone.dart';
import 'package:nivishka_android/OTPScreen/index.dart';
import 'package:nivishka_android/Home/index.dart';
import 'package:nivishka_android/AllCategories/index.dart';
import 'package:nivishka_android/PromoList/index.dart';
import 'package:nivishka_android/PromoDescription/index.dart';
import 'package:nivishka_android/BestPicks/index.dart';
import 'package:nivishka_android/FlashSale/index.dart';
import 'package:nivishka_android/CategoryDescription/index.dart';
import 'package:nivishka_android/ServiceListing/index.dart';
import 'package:nivishka_android/Receipt/index.dart';
import 'package:nivishka_android/ServiceLocationSelect/index.dart';
import 'package:nivishka_android/SelectLocation/index.dart';
import 'package:nivishka_android/SelectLocation/SelectOtherLocation.dart';
import 'package:nivishka_android/SelectDate/index.dart';
import 'package:nivishka_android/BookingHistory/index.dart';
import 'package:nivishka_android/Profile/index.dart';
import 'package:nivishka_android/Wallet/index.dart';
import 'package:nivishka_android/TopUpWallet/index.dart';
import 'package:nivishka_android/ReferAndEarn/index.dart';
import 'package:nivishka_android/About/index.dart';
import 'package:nivishka_android/GiftCard/index.dart';
import 'package:nivishka_android/GiftCard/VoucherCode.dart';
import 'package:nivishka_android/SendReport/index.dart';

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
      title: 'Nivishka',
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/splashScreen",
      routes: {
        "/splashScreen": (context) => SplashScreen(),
        "/enterPhone": (context) => EnterPhone(),
        "/chooseLoginSignup": (context) => ChooseLoginSignup(),
        "/signup": (context) => Signup(),
        "/otp_screen": (context) => OTPScreen(),
        "/home": (context) => Home(),
        "/allCategories": (context) => AllCategories(),
        "/about": (context) => About(),
        "/promoList": (context) => PromoList(),
        "/promoDesc": (context) => PromoDescription(),
        "/bestPicks": (context) => BestPicks(),
        "/flashSale": (context) => FlashSale(),
        "/categoryDescription": (context) => CategoryDescription(),
        "/serviceListing": (context) => ServiceListing(),
        "/receipt": (context) => Receipt(),
        "/serviceLocationSelect": (context) => ServiceLocationSelect(),
        "/selectLocation": (context) => SelectLocation(),
        "/selectOtherLocation": (context) => SelectOtherLocation(),
        "/selectDate": (context) => SelectDate(),
        "/bookingHistory": (context) => BookingHistory(),
        "/profile": (context) => Profile(),
        "/wallet": (context) => Wallet(),
        "/topupwallet": (context) => TopUpWallet(),
        "/referAndEarn": (context) => ReferAndEarn(),
        "/giftCard": (context) => GiftCard(),
        "/voucherCode": (context) => VoucherCode(),
        "/sendReport": (context) => SendReport(),
      },
    );
  }
}
