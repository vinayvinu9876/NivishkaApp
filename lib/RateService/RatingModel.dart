import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RatingModel extends ChangeNotifier {
  bool _isLoading = false;
  double _rating = 0;
  String _errorMessage;
  String _successMessage;

  bool get isLoading => _isLoading;
  double get rating => _rating;
  String get errorMessage => _errorMessage;
  String get successMessage => _successMessage;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFunctions functions = FirebaseFunctions.instance;

  void setRating(double ratingA) {
    _rating = ratingA;
    notifyListeners();
  }

  void giveRating(int orderId) {
    _successMessage = null;
    _errorMessage = null;
    notifyListeners();

    if (rating == null) {
      _errorMessage = "Please provide a rating";
      notifyListeners();
      return;
    }

    if (rating == 0) {
      _errorMessage = "Rating cannot be 0";
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    String uid = auth.currentUser.uid;

    HttpsCallable callable = functions.httpsCallable("rateOrder");

    Map<String, dynamic> payload = {
      "order_id": orderId,
      "rating": rating,
      "uid": uid,
    };

    callable(payload).then((HttpsCallableResult val) {
      Map<dynamic, dynamic> data = val.data;

      if (val.data["status"] == "failure") {
        _errorMessage = data["message"];
      } else {
        _successMessage = "Thank you for your valuable rating";
      }
      _isLoading = false;
      notifyListeners();
    }).catchError((e) {
      print(e);
      _isLoading = false;
      _errorMessage = e.message;
      notifyListeners();
      return;
    });
  }
}
