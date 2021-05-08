import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nivishka_android/AppServices/NavigatorService.dart';
import 'package:nivishka_android/AppServices/services.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';

class ReceiptModel extends ChangeNotifier {
  bool _isLoading = false, _isPromoLoading = false;
  String _errorMessage;
  Map<String, dynamic> _cartData = {};
  List<Map<String, dynamic>> _orderData = [];
  List<Map<String, dynamic>> _promoData = [];
  Map<String, dynamic> _selectedPromoCodeData = {};
  var _charges = 0;
  String _promoCode;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFunctions func = FirebaseFunctions.instance;

  StreamSubscription<DocumentSnapshot> _chargesSubscription;
  StreamSubscription<QuerySnapshot> promoSubscription;

  bool get isLoading => _isLoading;
  bool get isPromoLoading => _isPromoLoading;
  Map<String, dynamic> get cartData => _cartData;
  List<Map<String, dynamic>> get orderData => _orderData;
  List<Map<String, dynamic>> get promoData => _promoData;
  String get promoCode => _promoCode;
  int get charges => _charges;
  String get errorMessage => _errorMessage;
  Map<String, dynamic> get selectedPromoCodeData => _selectedPromoCodeData;

  Map<String, dynamic> getProcessedCartData() {
    Map<String, dynamic> temp = {};

    _cartData.keys.forEach((String key) {
      temp[key] = _cartData[key];
      print(temp[key]);
      temp[key].remove("create_date");
    });
    return temp;
  }

  void createOrder() {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    print("Creating order");
    String uid = auth.currentUser.uid;
    print("user id = $uid");
    HttpsCallable funcRef = func.httpsCallable("createOrder");
    print("About to call function");
    print(
        "cart Data = $_cartData and promocodeData = $_selectedPromoCodeData and uid = $uid");
    funcRef({
      "cartData": getProcessedCartData(),
      "promoId": _selectedPromoCodeData.containsKey("promo_id")
          ? _selectedPromoCodeData["promo_id"]
          : null,
      "uid": uid
    }).then((HttpsCallableResult resp) async {
      print("Response = ${resp.data}");
      if (resp.data["status"] == "success") {
        _isLoading = false;
        notifyListeners();
        await getIt<NavigationService>().navigateTo("/serviceLocationSelect");
      } else {
        _errorMessage = resp.data["message"];
        _isLoading = false;
        notifyListeners();
      }
    }).catchError((e) {
      _errorMessage = e.message;
      _isLoading = false;
      print("Error = $e");
      notifyListeners();
    });
  }

  void setCartData(Map<String, dynamic> tempCartData) {
    _cartData = tempCartData;
    getCharges();
    notifyListeners();

    if (_cartData.keys.length == 0) {
      getIt<NavigationService>().pop();
    }
  }

  void onDispose() {
    _cartData.clear();
    print("Destructing ondispose");
    _isLoading = false;
    _promoCode = null;
    _selectedPromoCodeData.clear();
    if (_chargesSubscription != null) {
      _chargesSubscription.cancel();
      _chargesSubscription = null;
    }
    if (promoSubscription != null) {
      promoSubscription.cancel();
      promoSubscription = null;
    }
    notifyListeners();
  }

  void getPromoData() {
    _isPromoLoading = true;
    notifyListeners();

    var currentDate = new DateTime.now();

    Query query = firestore
        .collection("Promo")
        .where("status", isEqualTo: "active")
        .where("end_date", isGreaterThan: currentDate);

    promoSubscription = query.snapshots().listen((QuerySnapshot snap) {
      _promoData.clear();
      snap.docs.forEach((QueryDocumentSnapshot doc) {
        _promoData.add(doc.data());
      });
      _isPromoLoading = false;
      notifyListeners();
    });

    promoSubscription.onError((e) {
      print(e);
    });
  }

  void addToCart(String serviceId) {
    // just for safety
    if (_cartData.containsKey(serviceId)) {
      _cartData[serviceId]["no_of_items"] += 1;
    }
    notifyListeners();
  }

  void removeFromCart(String serviceId) async {
    _cartData[serviceId]["no_of_items"] =
        _cartData[serviceId]["no_of_items"] - 1;
    if (_cartData[serviceId]["no_of_items"] == 0) _cartData.remove(serviceId);
    notifyListeners();

    if (_cartData.keys.length == 0) {
      getIt<NavigationService>().pop();
    }
  }

  void getCharges() {
    DocumentReference doc =
        firestore.collection("Charges").doc("other_charges");

    _chargesSubscription = doc.snapshots().listen((DocumentSnapshot doc) {
      _charges = doc.data()["charges"];
      notifyListeners();
    });

    _chargesSubscription.onError((e) {
      print(e);
    });
  }

  void setPromoCode(int selectedPromoCodeId) {
    _isPromoLoading = true;
    _selectedPromoCodeData.clear();
    _errorMessage = null;
    notifyListeners();
    User user = auth.currentUser;
    String uid = user.uid;

    var funcRef = func.httpsCallable("checkIfPromoApplicable");
    funcRef({"promoId": selectedPromoCodeId, "uid": uid})
        .then((HttpsCallableResult value) {
      if (value.data["status"] == "success") {
        _promoData.forEach((Map<String, dynamic> promoCodeData) {
          if (promoCodeData["promo_id"] == selectedPromoCodeId) {
            _selectedPromoCodeData = promoCodeData;
          }
        });
        _isPromoLoading = false;
        getIt<NavigationService>().pop();
        notifyListeners();
      } else {
        _errorMessage = value.data["message"];
        _isPromoLoading = false;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      print(error.message);
      _errorMessage = error.message;
      _isPromoLoading = false;
      notifyListeners();
    });
  }
}
