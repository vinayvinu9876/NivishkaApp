import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:nivishka_android/AppServices/NavigatorService.dart';
import 'package:nivishka_android/AppServices/services.dart';
import 'package:nivishka_android/Message/index.dart';

class SendReportModel extends ChangeNotifier {
  bool _isLoading = false;
  String _details, _phone, _errorMessage;

  bool get isLoading => _isLoading;
  String get details => _details;
  String get phone => _phone;
  String get errorMessage => _errorMessage;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void goToMessage(String message, IconData icon) async {
    await getIt<NavigationService>().navigatePage(Message(
      message: message,
      icon: icon,
    ));
  }

  void setDetails(String det) {
    _details = det;
    notifyListeners();
  }

  void setPhone(String ph) {
    _phone = ph;
    notifyListeners();
  }

  void sendReport() {
    if (isEmpty(_phone)) {
      _errorMessage = "Phone cannot be empty";
      notifyListeners();
      return;
    }
    if (isEmpty(_details)) {
      _errorMessage = "Please enter something";
      notifyListeners();
      return;
    }
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    CollectionReference ref = firestore.collection("UserMessageReport");

    Map<String, dynamic> toAdd = {
      "phone": _phone,
      "details": details,
      "createdDate": DateTime.now(),
      "seenDate": null,
      "uid": auth.currentUser.uid,
      "status": "sent",
    };

    ref.add(toAdd).then((DocumentReference docId) {
      print("Doc id = $docId");
      _isLoading = false;
      notifyListeners();
      goToMessage("Report Send succesfully", Icons.done);
    }).catchError((e) {
      _errorMessage = e.message;
      _isLoading = false;
      notifyListeners();
    });
  }
}
