import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nivishka_android/AppServices/services.dart';
import 'package:nivishka_android/AppServices/NavigatorService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nivishka_android/util/index.dart';

class HomeModel extends ChangeNotifier {
  User _currentUser;
  Map<String, dynamic> _userData;
  List<Map<String, dynamic>> _promoData = [];
  List<Map<String, dynamic>> _categoryData = [];
  bool _calledOnce = false;
  StreamSubscription<DocumentSnapshot> userSubscription;
  StreamSubscription<QuerySnapshot> promoSubscription;
  StreamSubscription<QuerySnapshot> categorySubscription;
  bool _isLoading = false;

  Map<String, dynamic> get userData => _userData;
  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get promoData => _promoData;
  List<Map<String, dynamic>> get categoryData => _categoryData;

  void cancelSubscriptions() {
    if (userSubscription != null) {
      userSubscription.cancel();
      userSubscription = null;
    }
    if (promoSubscription != null) {
      promoSubscription.cancel();
      promoSubscription = null;
    }
    if (categorySubscription != null) {
      categorySubscription.cancel();
      categorySubscription = null;
    }

    _calledOnce = false;
  }

  void getAllData() {
    if (_calledOnce) {
      return;
    }
    _calledOnce = true;
    getUserDetails();
  }

  void getUserDetails() async {
    _currentUser = FirebaseAuth.instance.currentUser;
    String uid;

    _isLoading = true;
    notifyListeners();

    if (_currentUser != null) {
      print("User uid = ${_currentUser.uid}");
      uid = _currentUser.uid;
    } else {
      await getIt<NavigationService>().navigateTo("/chooseLoginSignup");
      _isLoading = false;
      notifyListeners();
      return;
    }

    DocumentReference reference = firestore.collection("Users").doc(uid);

    Stream<DocumentSnapshot> userDataListener = reference.snapshots();

    userSubscription = userDataListener.listen((DocumentSnapshot doc) {
      if (!doc.exists) {
        _userData["name"] = "User Doesnt Exist";
        print("User Doesnt Exist");
        _isLoading = false;
        notifyListeners();
        return;
      }

      _userData = doc.data();
      getPromos(_userData);
      getCategories(_userData);

      print(_userData);
      _isLoading = false;
      notifyListeners();
    });

    userSubscription.onError((e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    });
  }

  void getPromos(Map<String, dynamic> userData) async {
    DateTime currentDate = new DateTime.now();
    Query query = firestore
        .collection("Promo")
        .where("status", isEqualTo: "active")
        .where("cities", arrayContains: userData["city_code"])
        .where("end_date", isGreaterThan: currentDate)
        .limit(6);

    Stream<QuerySnapshot> promoQuery = query.snapshots();

    promoSubscription = promoQuery.listen((QuerySnapshot snap) {
      _promoData.clear();
      snap.docs.forEach((DocumentSnapshot element) {
        _promoData.add(element.data());
      });
      print("Promo code size = ${snap.size}");
      notifyListeners();
    });

    promoSubscription.onError((e) {
      print(e);
    });
  }

  void getCategories(Map<String, dynamic> userData) async {
    Query query = firestore
        .collection("Category")
        .where("isActive", isEqualTo: true)
        .where("no_of_services", isGreaterThan: 0)
        .where("cities", arrayContains: userData["city_code"])
        .limit(10);

    print("Category query initialized");

    Stream<QuerySnapshot> catQuery = query.snapshots();

    categorySubscription = catQuery.listen((QuerySnapshot snap) {
      print("Got category data = ${snap.size}");
      _categoryData.clear();
      snap.docs.forEach((DocumentSnapshot doc) {
        _categoryData.add(doc.data());
      });
      notifyListeners();
    });

    categorySubscription.onError((e) {
      print(e);
    });
  }
}
