import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nivishka_android/util/index.dart';

class CategoryDescriptionModel extends ChangeNotifier {
  bool _isLoading = false;
  List<Map<String, dynamic>> _subCategoryData = [];
  List<Map<String, dynamic>> _partnerData = [];
  StreamSubscription<QuerySnapshot> subscription;
  StreamSubscription<QuerySnapshot> partnerSubscription;

  bool get isLoading => _isLoading;
  List<Map<String, dynamic>> get subCategoryData => _subCategoryData;
  List<Map<String, dynamic>> get partnerData => _partnerData;

  void cancelSubscriptions() {
    if (subscription != null) {
      subscription.cancel();
    }
    if (partnerSubscription != null) {
      partnerSubscription.cancel();
    }
  }

  void getCategoryData(String categoryName, String catID) {
    cancelSubscriptions();
    _isLoading = true;
    notifyListeners();

    Query query = firestore
        .collection("SubCategory")
        .where("cat_id", isEqualTo: catID)
        .where("isActive", isEqualTo: true);

    subscription = query.snapshots().listen((QuerySnapshot snap) {
      _subCategoryData.clear();

      snap.docs.forEach((QueryDocumentSnapshot element) {
        _subCategoryData.add(element.data());
      });

      _isLoading = false;
      notifyListeners();
    });
  }

  void getPartnersData(String categoryName, String catId, String cityName) {
    _isLoading = true;
    notifyListeners();

    Query query = firestore
        .collection("Partner")
        .where("cat_id", isEqualTo: int.parse(catId))
        .where("isActive", isEqualTo: true)
        .where("cities", arrayContains: cityName)
        .limit(5);

    partnerSubscription = query.snapshots().listen((QuerySnapshot snap) {
      _partnerData.clear();
      snap.docs.forEach((QueryDocumentSnapshot doc) {
        _partnerData.add(doc.data());
      });

      _isLoading = false;
      notifyListeners();
    });
  }
}
