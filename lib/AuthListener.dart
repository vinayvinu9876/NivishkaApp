import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nivishka_android/AppServices/NavigatorService.dart';
import 'package:nivishka_android/AppServices/services.dart';
import 'package:nivishka_android/util/index.dart';

class AuthListener extends ChangeNotifier {
  AuthListener() {
    print("AuthListener class has been initated now");
  }

  bool _isLoading = false;
  String _cityCode;
  FirebaseAuth auth = FirebaseAuth.instance;
  StreamSubscription<User> subscription;
  StreamSubscription<DocumentSnapshot> userListener;

  bool get isLoading => _isLoading;
  String get cityCode => _cityCode;

  void cancelListeners() {
    print("Cancelling auth listeners");
    _cityCode = null;
    if (subscription != null) subscription.cancel();
    if (userListener != null) userListener.cancel();
  }

  void listen() async {
    cancelListeners();
    cityCodeListen();
  }

  Future<void> cityCodeListen() async {
    User user = auth.currentUser;

    if (userListener != null) {
      userListener.cancel();
    }

    if (user == null) {
      authListen();
      return;
    }

    String uid = user.uid;
    DocumentReference doc = firestore.collection("Users").doc(uid);
    Stream<DocumentSnapshot> docStream = doc.snapshots();
    userListener = docStream.listen((DocumentSnapshot doc) async {
      Map<String, dynamic> data = doc.data();
      _cityCode = data["city_code"];
      if (data["city_code"] == null) {
        await getIt<NavigationService>()
            .navigateToAndRemoveUntill("/selectCity");
        userListener.cancel();
      } else {
        authListen();
      }
    });
  }

  void authListen() async {
    Stream<User> userStream = auth.authStateChanges();
    subscription = userStream.listen((User fireUser) async {
      if (fireUser != null) {
        await getIt<NavigationService>().navigateToAndRemoveUntill("/home");
        subscription.cancel();
      } else {
        print("No User forwaring to loginsignup");
        await getIt<NavigationService>()
            .navigateToAndRemoveUntill("/chooseLoginSignup");
        subscription.cancel();
      }
    });
  }
}
