import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:nivishka_android/SplashScreen/index.dart';
import 'package:nivishka_android/ChooseLoginSignup/index.dart';
import 'package:nivishka_android/Signup/index.dart';
import 'package:nivishka_android/Login/EnterPhone.dart';
import 'package:nivishka_android/Home/index.dart';
import 'package:nivishka_android/AllCategories/index.dart';
import 'package:nivishka_android/PromoList/index.dart';
import 'package:nivishka_android/PromoDescription/index.dart';
import 'package:nivishka_android/BestPicks/index.dart';
import 'package:nivishka_android/FlashSale/index.dart';
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
import 'package:nivishka_android/Search/index.dart';
import 'package:nivishka_android/SelectCity/index.dart';
import 'package:nivishka_android/Message/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';

import 'package:nivishka_android/Signup/SignupModel.dart';
import 'package:nivishka_android/OTPScreen/OTPModel.dart';
import 'package:nivishka_android/Home/HomeModel.dart';
import 'package:nivishka_android/SelectCity/SelectCityModel.dart';
import 'package:nivishka_android/CategoryDescription/CategoryDescriptionModel.dart';

import 'AppServices/NavigatorService.dart';
import 'AppServices/services.dart';
import "AuthListener.dart";

var kReleaseMode = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialAppCopy();
  }
}

class MaterialAppCopy extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SignupModel()),
          ChangeNotifierProvider(create: (context) => OTPModel()),
          ChangeNotifierProvider(create: (context) => AuthListener()),
          ChangeNotifierProvider(create: (context) => HomeModel()),
          ChangeNotifierProvider(create: (context) => SelectCityModel()),
          ChangeNotifierProvider(
              create: (context) => CategoryDescriptionModel())
        ],
        child: MaterialApp(
          title: 'Nivishka',
          navigatorKey: getIt<NavigationService>().navigatorKey,
          locale: DevicePreview.locale(context), // Add the locale here
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: "/splashScreen",
          home: StreamBuilder<User>(
            stream: auth.authStateChanges(),
            builder: (BuildContext context, snapshot) {
              var authModel = Provider.of<AuthListener>(context);
              authModel.listen();
              if (snapshot.hasData) {
                return Home();
              } else if (snapshot.hasError) {
                return Message(
                    message: "Authenitcation Error", icon: Icons.warning);
              } else {
                return ChooseLoginSignup();
              }
            },
          ),
          routes: {
            "/splashScreen": (context) => SplashScreen(),
            "/enterPhone": (context) => EnterPhone(),
            "/chooseLoginSignup": (context) => ChooseLoginSignup(),
            "/signup": (context) => Signup(),
            "/home": (context) => Home(),
            "/allCategories": (context) => AllCategories(),
            "/about": (context) => About(),
            "/promoList": (context) => PromoList(),
            "/promoDesc": (context) => PromoDescription(),
            "/bestPicks": (context) => BestPicks(),
            "/flashSale": (context) => FlashSale(),
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
            "/search": (context) => Search(),
            "/selectCity": (context) => SelectCity(),
          },
        ));
  }
}
