import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AllCategoryModel extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  Map<String, List<Map<String, dynamic>>> _categoryData = {};
  bool isRunning = false;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  Map<String, List<Map<String, dynamic>>> get categoryData => _categoryData;

  void getAllCategoryData() {
    if (isRunning) {
      return;
    }
    isRunning = true;
    _isLoading = true;
    _categoryData.clear();
    notifyListeners();

    String uid = auth.currentUser.uid;
    DocumentReference userDocRef = firestore.collection("Users").doc(uid);

    userDocRef.get().then((DocumentSnapshot doc) {
      if (!doc.exists) {
        _errorMessage = "User data not found";
        _isLoading = false;
        notifyListeners();
        return;
      }

      Map<String, dynamic> userData = doc.data();

      print("City code = ${userData["city_code"]}");

      Query query = firestore
          .collection("Category")
          .where("cities", arrayContains: userData["city_code"])
          .where("isActive", isEqualTo: true);

      Query serviceDataQuery = firestore
          .collection("Service")
          .where("cities", arrayContains: userData["city_code"])
          .where("isActive", isEqualTo: true);

      serviceDataQuery.snapshots().listen((QuerySnapshot snap) {
        print("Service data size = ${snap.size}");
        List<Map<String, dynamic>> serviceData = [];
        snap.docs.forEach((element) {
          serviceData.add(element.data());
        });

        query.snapshots().listen((QuerySnapshot snap) {
          print("Category query snap size = ${snap.size}");
          _categoryData.clear();
          Map<String, Map<String, dynamic>> tempCatData = {};

          snap.docs.forEach((QueryDocumentSnapshot doc) {
            Map<String, dynamic> catData = doc.data();
            tempCatData[doc.id] = catData;
          });

          print("Temp cat data keys = ${tempCatData.keys}");

          serviceData.forEach((Map<String, dynamic> element) {
            String key = tempCatData[element["cat_id"]]["catName"];
            if (_categoryData.keys.contains(key)) {
              _categoryData[key].add(element);
            } else {
              _categoryData[key] = [element];
            }
          });

          _isLoading = false;
          notifyListeners();
        }).onError((err) {
          _errorMessage = err.message;
          _isLoading = false;
          notifyListeners();
          print(err.message);
        });
      }).onError((err) {
        _errorMessage = err.message;
        _isLoading = false;
        print(err.message);
        notifyListeners();
      });
    }).onError((error, stackTrace) {
      _errorMessage = error.message;
      _isLoading = false;
      print(error.message);
      notifyListeners();
    });
  }
}
