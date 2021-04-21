import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nivishka_android/AppServices/NavigatorService.dart';
import 'package:nivishka_android/AppServices/services.dart';
import 'package:nivishka_android/util/index.dart';

class AuthListener extends ChangeNotifier {
  bool _isLoading = false;
  String _cityCode;
  FirebaseAuth auth = FirebaseAuth.instance;

  StreamSubscription<User> subscription;
  StreamSubscription<DocumentSnapshot> userListener;

  bool get isLoading => _isLoading;
  String get cityCode => _cityCode;

  void cancelListeners() {
    if (subscription != null) subscription.cancel();
    if (userListener != null) userListener.cancel();
  }

  void listen() async {
    authListen();
  }

  Future<void> cityCodeListen() async {
    User user = auth.currentUser;

    if (userListener != null) {
      userListener.cancel();
    }

    if (user == null) {
      return;
    }

    String uid = user.uid;
    DocumentReference doc = firestore.collection("Users").doc(uid);
    Stream<DocumentSnapshot> docStream = doc.snapshots();
    userListener = docStream.listen((DocumentSnapshot doc) async {
      Map<String, dynamic> data = doc.data();
      _cityCode = data["city_code"];
      if (data["city_code"] == null) {
        await getIt<NavigationService>().navigateTo("/selectCity");
      }
    });
  }

  void authListen() async {
    Stream<User> userStream = auth.authStateChanges();
    subscription = userStream.listen((User fireUser) async {
      if (fireUser != null) {
        cityCodeListen();
        await getIt<NavigationService>().navigateTo("/home");
      } else {
        await getIt<NavigationService>().navigateTo("/chooseLoginSignup");
      }
    });
  }
}
