import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingHistoryModel extends ChangeNotifier {
  bool _isLoading = false;
  bool _isScheduledLoading = false;
  bool _isCompletedLoading = false;
  bool _isCancelledLoading = false;
  String _errorMessage;
  List<Map<String, dynamic>> _pendingOrders = [];
  List<Map<String, dynamic>> _completedOrders = [];
  List<Map<String, dynamic>> _cancelledOrders = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  List<Map<String, dynamic>> get pendingOrders => _pendingOrders;
  List<Map<String, dynamic>> get completedOrders => _completedOrders;
  List<Map<String, dynamic>> get cancelledOrders => _cancelledOrders;
  bool get isScheduledLoading => _isScheduledLoading;
  bool get isCompletedLoading => _isCompletedLoading;
  bool get isCancelledLoading => _isCancelledLoading;

  void getPendingOrderData() {
    List<String> status = ["paid"];
    print("Getting pending orders");
    if (_pendingOrders.length == 0) {
      getOrdersData(status);
    }
  }

  void getCompletedOrderData() {
    List<String> status = ["completed", "success"];
    print("Getting completed orders");
    if (_completedOrders.length == 0) {
      getOrdersData(status);
    }
  }

  void getCancelledOrderData() {
    List<String> status = ["cancelled", "cancel", "failure"];
    print("getting cancelled orders");
    if (_cancelledOrders.length == 0) {
      getOrdersData(status);
    }
  }

  void getOrdersData(List<String> status) {
    if (status.contains("paid")) {
      // pending
      _isScheduledLoading = true;
    } else if (status.contains("success")) {
      _isCompletedLoading = true;
    } else {
      _isCancelledLoading = true;
    }
    _isLoading = true;
    notifyListeners();

    String uid = auth.currentUser.uid;

    Query query = firestore
        .collection("Order")
        .where("uid", isEqualTo: uid)
        .where("status", whereIn: status);

    query.snapshots().listen((event) {
      List<Map<String, dynamic>> temp = [];
      event.docs.forEach((element) => {temp.add(element.data())});
      if (status.contains("paid")) {
        // pending
        _pendingOrders = temp;
        _isScheduledLoading = false;
      } else if (status.contains("success")) {
        _completedOrders = temp;
        _isCompletedLoading = false;
      } else if (status.contains("failure")) {
        _cancelledOrders = temp;
        _isCancelledLoading = false;
      }
      _isLoading = false;
      notifyListeners();
    }).onError((e) {
      print(e);
      _isLoading = false;
      _errorMessage = e.message;
      notifyListeners();
    });
  }
}
