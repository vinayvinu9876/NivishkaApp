import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nivishka_android/AppServices/NavigatorService.dart';
import 'package:nivishka_android/AppServices/services.dart';

class SearchModel extends ChangeNotifier {
  bool _isLoading = false;
  String _citycode;

  List<Map<String, dynamic>> _categoryData = [];
  List<Map<String, dynamic>> _searchData = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get categoryData => _categoryData;
  List<Map<String, dynamic>> get searchData => _searchData;

  void getCategroyData() {
    _isLoading = true;
    notifyListeners();
    DocumentReference userRef =
        firestore.collection("Users").doc(auth.currentUser.uid);

    userRef.get().then((DocumentSnapshot doc) async {
      if (!doc.exists) {
        _isLoading = false;
        notifyListeners();
        await getIt<NavigationService>().navigateTo("/home");
        return;
      }
      var userData = doc.data();
      _citycode = userData["city_code"];
      Query query = firestore
          .collection("Category")
          .where("isActive", isEqualTo: true)
          .where("cities", arrayContains: userData["city_code"])
          .limit(8);
      query.get().then((QuerySnapshot snap) {
        _categoryData.clear();
        snap.docs.forEach((doc) {
          _categoryData.add(doc.data());
        });
        _isLoading = false;
        notifyListeners();
      }).onError((error, stackTrace) {
        print(error.message);

        _isLoading = false;
        notifyListeners();
      });
    }).onError((error, stackTrace) {
      print(error.message);

      _isLoading = false;
      notifyListeners();
    });
  }

  void searchServices(String searchVal) {
    if (_citycode == null) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    Query query = firestore
        .collection("Service")
        .where("isActive", isEqualTo: true)
        .where("cities", arrayContains: _citycode)
        .where("service_name", isGreaterThanOrEqualTo: searchVal)
        .orderBy("service_name")
        .limit(7);
    query.get().then((QuerySnapshot snap) {
      _searchData.clear();
      snap.docs.forEach((DocumentSnapshot element) {
        _searchData.add(element.data());
      });
      _isLoading = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      print(error.message);
      _isLoading = false;
      notifyListeners();
    });
  }
}
