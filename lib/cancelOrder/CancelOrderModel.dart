import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:nivishka_android/AppServices/NavigatorService.dart';
import 'package:nivishka_android/AppServices/services.dart';
import 'package:nivishka_android/Message/index.dart';

class CancelOrderModel extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage;
  String _cancellationReason;
  String _refundSpeed;
  int _orderId;

  FirebaseFunctions functions = FirebaseFunctions.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  bool get isLoading => _isLoading;
  String get cancellationReason => _cancellationReason;
  String get refundSpeed => _refundSpeed;
  String get errorMessage => _errorMessage;
  int get orderId => _orderId;

  void setCancellationReason(String reason) {
    _cancellationReason = reason;
    notifyListeners();
  }

  void setRefundSpeed(String speed) {
    _refundSpeed = speed;
    notifyListeners();
  }

  void setOrderId(int orderIdArg) {
    _orderId = orderIdArg;
    notifyListeners();
  }

  void cancelOrder() {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    if (isEmpty(_orderId)) {
      _errorMessage = "Order id not found";
    } else if (isEmpty(_cancellationReason)) {
      _errorMessage = "Please Select a Reason";
    } else if (isEmpty(_refundSpeed)) {
      _errorMessage = "Please Refund Speed";
    }

    if (_errorMessage != null) {
      _isLoading = false;
      notifyListeners();
      return;
    }

    HttpsCallable cancelOrderfuncRef = functions.httpsCallable("cancelOrder");

    Map<String, dynamic> data = {
      "order_id": _orderId,
      "uid": auth.currentUser.uid,
      "cancellationReason": _cancellationReason,
      "refundSpeed": _refundSpeed,
    };

    print("Data = $data");

    cancelOrderfuncRef(data).then((HttpsCallableResult res) async {
      _isLoading = false;
      _cancellationReason = null;
      _refundSpeed = null;
      if (res.data["status"] == "success") {
        await getIt<NavigationService>().navigatePage(
            Message(message: res.data["message"], icon: Icons.done));
      } else {
        await getIt<NavigationService>().navigatePage(
            Message(message: res.data["message"], icon: Icons.warning));
        notifyListeners();
      }
      notifyListeners();
    }).onError((e, stacktrance) async {
      print(e);
      _cancellationReason = null;
      _refundSpeed = null;
      _isLoading = false;

      await getIt<NavigationService>()
          .navigatePage(Message(message: e.message, icon: Icons.warning));
      notifyListeners();
    });
  }
}
