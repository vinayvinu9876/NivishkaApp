import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServiceListingModel extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  String currCatID;

  FirebaseAuth auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> _subCategoryData = [];
  Map<String, List<Map<String, dynamic>>> _servicesData = {};
  Map<String, dynamic> _cartData = {};

  StreamSubscription<QuerySnapshot> _streamSubscription;
  StreamSubscription<QuerySnapshot> _serviceSubscription;

  List<Map<String, dynamic>> get subCategoryData => _subCategoryData;
  Map<String, List<Map<String, dynamic>>> get servicesData => _servicesData;
  Map<String, dynamic> get cartData => _cartData;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> setErrorMessage(String msg) async {
    _errorMessage = msg;
    notifyListeners();

    new Future.delayed(const Duration(milliseconds: 3000), () {
      print("Done");
      _errorMessage = null;
      notifyListeners();
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  void killAllSubscriptions() {
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
      _streamSubscription = null;
    }
    if (_serviceSubscription != null) {
      _serviceSubscription.cancel();
      _serviceSubscription = null;
    }

    _subCategoryData.clear();
    _servicesData.clear();
  }

  void callEverything(String catId) {
    if (currCatID == catId) {
      return;
    }
    killAllSubscriptions();
    clearCart();
    getSubCategoryData(catId);
    getServiceData(catId);
  }

  void clearCart() {
    _cartData.clear();
  }

  void getSubCategoryData(String catId) {
    if (catId == null || catId == "") {
      print("Cat id is empty $catId");
      return;
    }

    _isLoading = true;
    notifyListeners();

    Query query = firestore
        .collection("SubCategory")
        .where("cat_id", isEqualTo: catId)
        .where("no_of_services", isGreaterThan: 0);

    _streamSubscription = query.snapshots().listen((QuerySnapshot snap) {
      _subCategoryData.clear();
      snap.docs.forEach((element) {
        _subCategoryData.add(element.data());
      });

      _isLoading = false;
      notifyListeners();
    });
  }

  void getServiceData(String catID) {
    _isLoading = true;
    notifyListeners();

    Query query = firestore
        .collection("Service")
        .where("cat_id", isEqualTo: catID)
        .where("isActive", isEqualTo: true);

    _serviceSubscription = query.snapshots().listen((QuerySnapshot snap) {
      _servicesData.clear();
      snap.docs.forEach((QueryDocumentSnapshot doc) {
        var data = doc.data();
        if (!(_servicesData.containsKey(data["sub_cat_id"]))) {
          _servicesData[data["sub_cat_id"]] = [data];
        } else {
          // update the json https://stackoverflow.com/questions/53908405/how-to-add-a-new-pair-to-map-in-dart
          _servicesData.update(data["sub_cat_id"], (value) {
            value.add(data);
            return value;
          });
        }
      });
      _isLoading = false;
      notifyListeners();
    });

    _serviceSubscription.onError((e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    });
  }

  void addToCart(String serviceId, Map<String, dynamic> serviceData) {
    if (_cartData.containsKey(serviceId)) {
      _cartData[serviceId]["no_of_items"] += 1;
    } else {
      serviceData["no_of_items"] = 1;
      _cartData[serviceId] = serviceData;
    }
    notifyListeners();
  }

  void removeFromCart(String serviceId) {
    if (!(_cartData.containsKey(serviceId))) {
      return;
    }

    _cartData[serviceId]["no_of_items"] =
        _cartData[serviceId]["no_of_items"] - 1;
    if (_cartData[serviceId]["no_of_items"] == 0) _cartData.remove(serviceId);
    notifyListeners();
  }
}
