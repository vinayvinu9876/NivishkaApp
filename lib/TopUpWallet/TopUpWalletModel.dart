import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:nivishka_android/AppServices/NavigatorService.dart';
import 'package:nivishka_android/AppServices/services.dart';
import 'package:nivishka_android/Message/index.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class TopUpWalletModel extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  int _topUpValue = 100;
  var _razorpay = Razorpay();

  bool get isLoading => _isLoading;
  int get topUpValue => _topUpValue;
  String get errorMessage => _errorMessage;

  FirebaseFunctions functions = FirebaseFunctions.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  void setTopUpValue(int value) {
    _topUpValue = value;
    notifyListeners();
  }

  void goToMessage(String message, IconData icon) async {
    await getIt<NavigationService>().navigatePage(Message(
      message: message,
      icon: icon,
      backActive: true,
    ));
  }

  void addMoneyToWallet() {
    if (_topUpValue == null || _topUpValue == 0) {
      _errorMessage = "Please Enter a value";
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    String uid = auth.currentUser.uid;

    HttpsCallable funcRef = functions.httpsCallable("addMoneyToWallet");

    funcRef({"uid": uid, "money": _topUpValue}).then((HttpsCallableResult res) {
      _isLoading = false;
      notifyListeners();
      if (res.data["status"] == "success") {
        openPayment(res.data["order_id"]);
      } else {
        goToMessage(res.data["message"], Icons.warning);
      }
    }).catchError((e) async {
      _isLoading = false;
      notifyListeners();
      goToMessage(e.message, Icons.warning);
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
    _razorpay.clear();
    goToMessage("Money Added to Wallet Succesfully", Icons.done);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Failed");
    _razorpay.clear();
    goToMessage("Cancelled Payment", Icons.warning);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print("External Wallet");
    _razorpay.clear();
    goToMessage("Chose External Wallet  " + response.walletName, Icons.warning);
  }
}
