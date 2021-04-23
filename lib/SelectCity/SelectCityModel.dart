import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nivishka_android/AppServices/NavigatorService.dart';
import 'package:nivishka_android/AppServices/services.dart';
import 'dart:async';

class SelectCityModel extends ChangeNotifier {
  String _selectedCityCode, _errorMessage;
  bool _isLoading = false;
  List<Map<String, dynamic>> _cityData = [];
  StreamSubscription<QuerySnapshot> cityListener;
  FirebaseAuth auth = FirebaseAuth.instance;

  String get selectedCityCode => _selectedCityCode;
  String get errorMessage => _errorMessage;
  List<Map<String, dynamic>> get cityData => _cityData;
  bool get isLoading => _isLoading;

  void setCity(cityname) {
    _selectedCityCode = cityname;
    notifyListeners();
  }

  void cancelListeners() {
    if (cityListener != null) {
      cityListener.cancel();
      cityListener = null;
    }
  }

  void getCityData() async {
    cancelListeners();

    _isLoading = true;
    notifyListeners();

    Query query =
        firestore.collection("City").where("isActive", isEqualTo: true);

    Stream<QuerySnapshot> queryStream = query.snapshots();

    cityListener = queryStream.listen((QuerySnapshot snap) {
      _cityData.clear();
      snap.docs.forEach((QueryDocumentSnapshot doc) {
        _cityData.add(doc.data());
      });

      _isLoading = false;
      notifyListeners();
    });
  }

  void updateCityCode() async {
    _errorMessage = null;
    if (isEmpty(_selectedCityCode)) {
      print("SelectedCityCode is empty");
      return;
    }

    _isLoading = true;
    notifyListeners();

    User user = auth.currentUser;

    DocumentReference doc = firestore.collection("Users").doc(user.uid);

    doc.update({"city_code": _selectedCityCode}).then((value) async {
      _isLoading = false;
      notifyListeners();
      await getIt<NavigationService>().navigateTo("/home");
    }).onError((error, stackTrace) {
      _errorMessage = error.message;
      _isLoading = false;
      notifyListeners();
    });
  }
}
