import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingDetailsModel extends ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic> _partnerData;
  Map<String, dynamic> _paymentData;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String, dynamic> get partnerData => _partnerData;
  Map<String, dynamic> get paymentData => _paymentData;
  bool get isLoading => _isLoading;

  void getData(int orderId) async {
    _isLoading = true;
    notifyListeners();
    await getPartnerData(orderId).catchError((e) {
      print(e);
    });
    await getPaymentData(orderId).catchError((e) {
      print(e);
    });
    _isLoading = false;
    notifyListeners();
  }

  Future<void> getPartnerData(int orderId) async {
    _partnerData = null;

    Query query = firestore
        .collection("OrderSchedule")
        .where("order_id", isEqualTo: orderId)
        .where("status", whereIn: ["success", "active"]);
    await query.get().then((QuerySnapshot snap) {
      if (snap.size > 0) {
        _partnerData = snap.docs.first.data();
        notifyListeners();
      }
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> getPaymentData(int orderId) async {
    _paymentData = null;
    Query query = firestore
        .collection("Payments")
        .where("order_id", isEqualTo: orderId.toString())
        .where("status", whereIn: ["captured", "authorized"]).orderBy(
            "createDate",
            descending: true);

    await query.get().then((QuerySnapshot snap) {
      print("Payment Snap size = ${snap.size}");
      if (snap.size > 0) {
        _paymentData = snap.docs.first.data();
        print("PaymentData = $_paymentData}");
      }
    }).catchError((e) {
      print(e);
    });
  }
}
