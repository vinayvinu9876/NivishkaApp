import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReferAndEarnModel extends ChangeNotifier {
  bool _isLoading = false;
  bool isRunning = false;
  String _errorMessage;

  Map<String, dynamic> _referalLimitsData;
  Map<String, dynamic> _userData;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  bool get isLoading => _isLoading;
  Map<String, dynamic> get referalLimitsData => _referalLimitsData;
  Map<String, dynamic> get userData => _userData;
  String get errorMessage => _errorMessage;

  void getReferalLimitsData() {
    if (isRunning) {
      return;
    }
    isRunning = true;
    _isLoading = true;
    notifyListeners();
    getUserReferalCode();

    DocumentReference ref =
        firestore.collection("ReferalCodeLimits").doc("limits");
    ref.snapshots().listen((DocumentSnapshot doc) {
      if (!doc.exists) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      _referalLimitsData = doc.data();
      _isLoading = false;
      notifyListeners();
    }).onError((e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    });
  }

  void getUserReferalCode() {
    String uid = auth.currentUser.uid;

    if (uid == null) {
      return;
    }

    DocumentReference docRef = firestore.collection("Users").doc(uid);

    docRef.get().then((value) {
      if (value.exists) {
        _userData = value.data();
        notifyListeners();
      } else {
        print("User data not found");
      }
    }).catchError((e) {
      print(e);
    });
  }
}
