import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:nivishka_android/AppServices/NavigatorService.dart';
import 'package:nivishka_android/AppServices/services.dart';

class SelectDateModel extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  int _start = 0, _end = 0, _diff = 0;
  DateTime _selectedDate = DateTime.now();
  int _selectedTime;

  FirebaseFunctions functions = FirebaseFunctions.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  var _razorpay = Razorpay();

  bool get isLoading => _isLoading;
  DateTime get selectedDate => _selectedDate;
  int get start => _start;
  int get end => _end;
  int get diff => _diff;
  int get selectedTime => _selectedTime;
  String get errorMessage => _errorMessage;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    _selectedTime = null;
    notifyListeners();
  }

  void setSelectedTime(int time) {
    _selectedTime = time;
    notifyListeners();
  }

  void getStartAndEndTime() {
    _isLoading = true;
    notifyListeners();

    DocumentReference docRef = firestore.collection("Time").doc("time");

    docRef.get().then((DocumentSnapshot doc) {
      _isLoading = false;
      Map<String, dynamic> data = doc.data();
      _start = data["start_time"];
      _end = data["end_time"];
      _diff = data["difference"];
      notifyListeners();
    }).catchError((err) {
      print(err);
      _isLoading = false;
      notifyListeners();
    });
  }

  void updateDateAndTime() {
    if (_isLoading) {
      // donot call twice
      return;
    }

    _errorMessage = null;
    _isLoading = true;
    notifyListeners();

    HttpsCallable funcRef = functions.httpsCallable("updateOrderTimeAndAllot");

    print(
        "User uid = ${auth.currentUser.uid} , selectedDAte = $_selectedDate and time = $_selectedTime");

    funcRef({
      "uid": auth.currentUser.uid,
      "date": _selectedDate.millisecondsSinceEpoch,
      "time": _selectedTime
    }).then((HttpsCallableResult res) {
      print("${res.data}");
      if (res.data["status"] == "success") {
        _isLoading = false;
        openPayment(res.data["payment_order_id"]);
        notifyListeners();
        return;
      }
      _errorMessage = res.data["message"];
      _isLoading = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      print(error.message);
      _errorMessage = error.message;
      _isLoading = false;
      notifyListeners();
    });
  }

  openPayment(String orderId) {
    var options = {'key': "rzp_test_egLcXs5WAFopw0", "order_id": orderId};
    _razorpay.open(options);

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    print("Success");
    await getIt<NavigationService>()
        .navigateToAndRemoveUntill("/bookingHistory");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Failed");
    _errorMessage = "Payment Cancelled";
    notifyListeners();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print("External Wallet");
  }
}
