import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:nivishka_android/util/isEmpty.dart';
import 'package:nivishka_android/AppServices/NavigatorService.dart';
import 'package:nivishka_android/AppServices/services.dart';
import 'package:nivishka_android/OTPScreen/index.dart';

class SignupModel extends ChangeNotifier {
  String _phone, _fname, _lname, _referalCode, _email, _countryCode = "91";
  bool _isLoading = false;
  String _errorMessage, _statusMessage;
  FirebaseFunctions functions = FirebaseFunctions.instance;

  String get phone => _phone;
  String get errorMessage => _errorMessage;
  String get fname => _fname;
  String get lname => _lname;
  String get referalCode => _referalCode;
  String get email => _email;
  String get statusMessage => _statusMessage;
  bool get isLoading => _isLoading;
  String get countryCode => _countryCode;

  void setPhone(String phone) {
    _phone = phone;
  }

  void setFname(String fname) {
    _fname = fname;
  }

  void setLname(String lname) {
    _lname = lname;
  }

  void setReferalCode(String code) {
    _referalCode = code;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setCountryCode(String countryCode) {
    _countryCode = countryCode;
  }

  Future<void> signupUser() async {
    _statusMessage = null;
    _errorMessage = null;

    print("clicked signup user");

    if (isEmpty(_fname)) {
      _errorMessage = "First Name cannot be empty";
    } else if (isEmpty(_lname)) {
      _errorMessage = "Last Name cannot be empty";
    } else if (isEmpty(_email)) {
      _errorMessage = "Email cannot be empty";
    } else if (isEmpty(_phone)) {
      _errorMessage = "Phone cannot be empty";
    } else if (isEmpty(_referalCode)) {
      _errorMessage = "Referal code Cannot be empty";
    } else if (isEmpty(_countryCode)) {
      _errorMessage = "Country Code cannot be empty";
    }

    print(
        "Fname = $_fname Last Name = $_lname Phone = $_phone Email = $_email referalcode = $_referalCode");

    if (_errorMessage != null) {
      print("Error $_errorMessage");
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('SignUpNewUser');

    Map<String, String> userData = {
      "fname": _fname,
      "lname": _lname,
      "phone": _phone,
      "email": _email,
      "referalCode": _referalCode,
      "countryCode": _countryCode,
    };

    final results = await callable(userData);

    var status = results.data;

    if (status["status"] == "success") {
      _statusMessage = "Successful";
      _isLoading = false;
      await getIt<NavigationService>().navigatePage(OTPScreen(phone: _phone));
      setAllFieldsAsNull();
    } else {
      _errorMessage = status["message"];
    }

    print("Message = $_statusMessage error = $_errorMessage");
    _isLoading = false;
    notifyListeners();
    return;
  }

  void setAllFieldsAsNull() {
    _fname = null;
    _lname = null;
    _phone = null;
    _referalCode = null;
    _email = null;
    notifyListeners();
  }
}
