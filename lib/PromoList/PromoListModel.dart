import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PromoListModel extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  List<Map<String, dynamic>> _promoList = [];

  bool isRunning = false;

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get promoList => _promoList;
  String get errorMessage => _errorMessage;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void getPromoList() {
    if (isRunning) {
      return;
    }
    isRunning = true;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    DateTime currentDate = DateTime.now();
    String uid = auth.currentUser.uid;
    DocumentReference userRef = firestore.collection("Users").doc(uid);

    userRef.get().then((DocumentSnapshot doc) {
      if (!doc.exists) {
        _errorMessage = "User Data not found";
        _isLoading = false;
        notifyListeners();
        return;
      }
      Map<String, dynamic> userData = doc.data();

      Query query = firestore
          .collection("Promo")
          .where("status", isEqualTo: "active")
          .where("cities", arrayContains: userData["city_code"])
          .where("end_date", isGreaterThan: currentDate);
      query.snapshots().listen((QuerySnapshot snap) {
        _errorMessage = null;
        List<Map<String, dynamic>> tempData = [];
        snap.docs.forEach((QueryDocumentSnapshot doc) {
          tempData.add(doc.data());
        });
        _promoList = tempData;
        _isLoading = false;
        notifyListeners();
      }).onError((e) {
        print(e);
        _errorMessage = e.message;
        _isLoading = false;
        notifyListeners();
      });
    }).onError((error, stackTrace) {
      _errorMessage = error.message;
      _isLoading = false;
      notifyListeners();
    });
  }
}
