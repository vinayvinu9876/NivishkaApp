import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PromoDescriptionModel extends ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic> _promoData;
  String _errorMessage;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String, dynamic> get promoData => _promoData;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void getPromoData(int promoId) {
    _isLoading = true;
    _promoData = null;
    notifyListeners();

    DocumentReference docRef =
        firestore.collection("Promo").doc(promoId.toString());

    docRef.get().then((DocumentSnapshot doc) {
      _promoData = doc.data();
      _isLoading = false;
      notifyListeners();
    }).catchError((e) {
      print(e);
      _isLoading = false;
      _errorMessage = e.message;
      notifyListeners();
    });
  }
}
