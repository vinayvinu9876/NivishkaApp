import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:nivishka_android/util/isEmpty.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "dart:async";

class OTPModel extends ChangeNotifier {
  String _otp, _errorMessage, _phone;
  int _nextOTPDelay = 120;
  bool _isLoading = false;
  Timer _timer;

  String get otp => _otp;
  bool get isLoading => _isLoading;
  String get phone => _phone;
  String get errorMessage => _errorMessage;
  int get nextOTPDelay => _nextOTPDelay;

  FirebaseAuth auth = FirebaseAuth.instance;

  void cancelListeners() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  void setPhoneNo(String value) {
    _phone = value;

    print("Phone = $phone");
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_nextOTPDelay == 0) {
          timer.cancel();
        } else {
          _nextOTPDelay--;
          notifyListeners();
        }
      },
    );
    return;
  }

  setOTP(String otp) {
    _otp = otp;
    notifyListeners();
    return;
  }

  Future<void> resendOTP() async {
    _errorMessage = null;
    notifyListeners();

    if (isEmpty(_phone)) {
      _errorMessage = "Phone cannot be empty";
      notifyListeners();
      return;
    }

    if (_nextOTPDelay == 0) {
      _isLoading = true;
      notifyListeners();

      //call for resend OTP
      Map<String, String> newOTPData = {
        "phone": _phone,
      };

      HttpsCallable callable =
          FirebaseFunctions.instance.httpsCallable('resendOTP');

      final results = await callable(newOTPData);

      var status = results.data;

      if (status["status"] == "success") {
        _errorMessage = "OTP Sent Succesfully";
      } else {
        _errorMessage = status["message"];
      }

      _isLoading = false;
      notifyListeners();
    } else {
      _errorMessage = "Please Try after $_nextOTPDelay seconds";
      notifyListeners();
    }
  }

  Future<void> verifyOTP() async {
    _errorMessage = null;
    notifyListeners();

    if (isEmpty(_phone)) {
      _errorMessage = "Phone No. Not found";
      notifyListeners();
      return;
    }

    if (isEmpty(_otp)) {
      _errorMessage = "Pleae Enter OTP";
      notifyListeners();
      return;
    }

    if (_otp.length < 4) {
      _errorMessage = "OTP cannot be lesser than 4 digits";
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('verifyOTP');

    Map<String, String> otpData = {
      "phone": _phone,
      "otp": _otp,
    };

    final results = await callable(otpData);

    var status = results.data;

    if (status["status"] == "success") {
      print("Succesfully Logged In");
      await auth.signInWithCustomToken(status["token"]);
    } else {
      _errorMessage = status["message"];
      print("Error $_errorMessage");
    }

    _isLoading = false;
    notifyListeners();
  }
}
