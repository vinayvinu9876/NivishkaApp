import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class WalletModel extends ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic> _walletData;
  List<Map<String, dynamic>> _walletTransactions = [];
  Map<DateTime, List<Map<String, dynamic>>> _dividedTransactionsData = {};

  StreamSubscription<DocumentSnapshot> walletsubscription;
  StreamSubscription<QuerySnapshot> transactionSubscription;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFunctions functions = FirebaseFunctions.instance;

  bool get isLoading => _isLoading;
  Map<String, dynamic> get walletData => _walletData;
  Map<DateTime, List<Map<String, dynamic>>> get dividedTransactionsData =>
      _dividedTransactionsData;

  void getWalletData() async {
    _isLoading = true;
    notifyListeners();
    String uid = auth.currentUser.uid;
    getWalletBalanceData(uid);
    getWalletTransactions(uid);
  }

  Future<void> getWalletBalanceData(String uid) async {
    if (walletsubscription != null) walletsubscription.cancel();

    DocumentReference doc = firestore.collection("Wallet").doc(uid);

    walletsubscription = doc.snapshots().listen((DocumentSnapshot doc) {
      if (!doc.exists) {
        print("Walllet data doesnt exist");
        _isLoading = false;
        notifyListeners();
        return;
      }
      _walletData = doc.data();
      _isLoading = false;
      notifyListeners();
    });

    walletsubscription.onError((e) {
      _isLoading = false;
      notifyListeners();
      print(e);
    });
  }

  void getWalletTransactions(String uid) {
    if (transactionSubscription != null) {
      transactionSubscription.cancel();
    }

    Query query = firestore
        .collection("Payments")
        .where("uid", isEqualTo: uid)
        .where("entity", isEqualTo: "wallet")
        .where("status", isEqualTo: "captured")
        .orderBy("createDate", descending: true);
    transactionSubscription = query.snapshots().listen((QuerySnapshot snap) {
      _walletTransactions.clear();
      _dividedTransactionsData.clear();
      snap.docs.forEach((QueryDocumentSnapshot element) {
        Map<String, dynamic> data = element.data();
        _walletTransactions.add(data);

        DateTime key = data["createDate"].toDate();
        var temp = key.toLocal();
        key = new DateTime(temp.year, temp.month, temp.day, 0, 0, 0, 0);
        if (_dividedTransactionsData.containsKey(key)) {
          _dividedTransactionsData[key].add(data);
        } else {
          _dividedTransactionsData[key] = [data];
        }
      });

      _isLoading = false;
      notifyListeners();
    });

    transactionSubscription.onError((e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    });
  }
}
