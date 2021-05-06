import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nivishka_android/AppServices/NavigatorService.dart';
import 'package:nivishka_android/AppServices/services.dart';
import 'package:nivishka_android/Message/index.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileModel extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  Map<String, dynamic> _userData;
  bool isRunning = false;

  bool get isLoading => _isLoading;
  Map<String, dynamic> get userData => _userData;
  String get errorMessage => _errorMessage;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void getUserData() {
    if (isRunning) {
      return;
    }
    _userData = null;
    isRunning = true;
    _isLoading = true;
    notifyListeners();

    String uid = auth.currentUser.uid;

    DocumentReference userDocRef = firestore.collection("Users").doc(uid);

    userDocRef.snapshots().listen((DocumentSnapshot doc) {
      if (!doc.exists) {
        _errorMessage = "User doesnt exist";
        _isLoading = false;
        notifyListeners();
        return;
      }
      _userData = doc.data();
      _isLoading = false;
      notifyListeners();
    }).onError((e) {
      _errorMessage = e.message;
      _isLoading = false;
      print(e);
      notifyListeners();
    });
  }

  void showSignoutErrorMessage(String message) async {
    await getIt<NavigationService>().navigatePage(Message(
      message: "$message",
      icon: Icons.warning,
      backActive: true,
    ));
  }

  void logout() {
    auth.signOut().then((value) async {
      await getIt<NavigationService>().navigateTo("/chooseLoginSignup");
    }).catchError((e) {
      showSignoutErrorMessage(e.message);
    });
  }
}
