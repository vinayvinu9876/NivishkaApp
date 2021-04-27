import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:nivishka_android/AppServices/NavigatorService.dart';
import 'package:nivishka_android/AppServices/services.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:nivishka_android/OTPScreen/index.dart';

class LoginModel extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  String _phone;
  String _otp;

  FirebaseFunctions func = FirebaseFunctions.instance;

  bool get isLoading => _isLoading;
  String get phone => _phone;
  String get otp => _otp;
  String get errorMessage => _errorMessage;

  void setPhone(String phoneNo) {
    _phone = phoneNo;
    notifyListeners();
  }

  void setOTP(String otpNo) {
    _otp = otpNo;
    notifyListeners();
  }

  void login() {
    print("Phone = $_phone");
    if (isEmpty(_phone)) {
      _errorMessage = "Phone cannot be empty";
      notifyListeners();
      return;
    }

    if (_phone.length < 10) {
      _errorMessage = "Phone no. cannot be lesser than 10";
      notifyListeners();
      return;
    }

    _errorMessage = null;
    _isLoading = true;
    notifyListeners();

    HttpsCallable callable = func.httpsCallable("login");

    callable({"phone": _phone}).then((HttpsCallableResult res) async {
      print("${res.data}");
      if (res.data["status"] == "success") {
        _isLoading = false;
        await getIt<NavigationService>().navigatePage(OTPScreen(phone: phone));
        notifyListeners();
      } else {
        _errorMessage = res.data["message"];
        _isLoading = false;
        notifyListeners();
      }
    });
  }
}
