import 'package:flutter/material.dart';
import "../AuthListener.dart";
import 'package:provider/provider.dart';
import '../StatisticsModel.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var authModel = Provider.of<AuthListener>(context, listen: false);
    var statModel = Provider.of<StatisticsModel>(context, listen: false);
    print("initstate splashscreen");
    statModel.updateOpenedRef();
    authModel.listen();
  }

  /*
  final threeSec = const Duration(seconds: 3);
  
  @override
  void initState() {
    super.initState();
    var authModel = Provider.of<AuthListener>(context, listen: false);
    authModel.listen();
    new Timer.periodic(threeSec, (Timer t) {
      Navigator.pushNamed(context, "/chooseLoginSignup");
      t.cancel();
    });
  }*/

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
