import 'package:flutter/material.dart';
import 'dart:async';

class EnterPhoneModel extends ChangeNotifier {
  String _phone, _otp;
  String _phoneError, _otpError;

  String get phone => _phone;
  String get otp => _otp;
  String get phoneError => _phoneError;
  String get otpError => _otpError;
}
