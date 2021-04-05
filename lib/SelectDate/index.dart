import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SelectDate extends StatefulWidget {
  @override
  State<SelectDate> createState() => _SelectDate();
}

class _SelectDate extends State<SelectDate> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    var _razorpay = Razorpay();

    void _handlePaymentSuccess(PaymentSuccessResponse response) {
      // Do something when payment succeeds
      print("Success");
    }

    void _handlePaymentError(PaymentFailureResponse response) {
      // Do something when payment fails
      print("Failed");
    }

    void _handleExternalWallet(ExternalWalletResponse response) {
      // Do something when an external wallet was selected
      print("External Wallet");
    }

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    openPayment() {
      var options = {
        'key': 'rzp_test_0dMyoBh7KWn48o',
        'amount': 100,
        'name': 'Acme Corp.',
        'description': 'Fine T-Shirt',
        'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
      };
      _razorpay.open(options);
    }

    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            bottomNavigationBar: InkWell(
                onTap: () {
                  openPayment();
                },
                child: Container(
                    height: 60,
                    color: Colors.grey[200],
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 12),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green[500],
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text("Next ",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)))))),
            appBar: AppBar(
                backgroundColor: Colors.green[500],
                title:
                    Text("Plumbers", style: GoogleFonts.poppins(fontSize: 14))),
            body: Container(
                height: height,
                width: width,
                padding: EdgeInsets.all(10),
                child: ListView(children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text("When would you like Nivishka Services to serve you?",
                      style: GoogleFonts.poppins(
                          color: Colors.black, fontSize: 14)),
                  SizedBox(height: 15),
                  Text("Select date of service",
                      style: GoogleFonts.poppins(
                          color: Colors.grey[600], fontSize: 10)),
                  SizedBox(height: 10),
                  Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        dateWidget("Today", "18"),
                        dateWidget("Tommorow", "19", active: true),
                        dateWidget("Sat", "20"),
                        dateWidget("Sun", "21"),
                      ])),
                  SizedBox(height: 10),
                  Text("Select Time",
                      style: GoogleFonts.poppins(
                          color: Colors.grey[600], fontSize: 10)),
                  SizedBox(height: 10),
                  Container(
                      child: Wrap(
                          spacing: 10.0,
                          runSpacing: 10.0,
                          alignment: WrapAlignment.spaceBetween,
                          runAlignment: WrapAlignment.center,
                          children: [
                        timeWidget("8 am"),
                        timeWidget("9 am"),
                        timeWidget("10 am"),
                        timeWidget("11 am"),
                        timeWidget("12 am"),
                        timeWidget("1 pm")
                      ]))
                ]))));
  }

  Widget timeWidget(String title) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        width: width * 0.45,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: Colors.grey[400])),
        child: Center(
            child: Text("$title",
                style: GoogleFonts.poppins(color: Colors.grey[600]))));
  }

  Widget dateWidget(String title, String date, {bool active = false}) {
    return Expanded(
        flex: 1,
        child: Container(
            margin: EdgeInsets.only(left: 3, right: 3),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: active ? Colors.black : Colors.grey[300],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("$title",
                      style: GoogleFonts.poppins(
                          color: active ? Colors.black : Colors.grey[600],
                          fontWeight:
                              active ? FontWeight.bold : FontWeight.normal,
                          fontSize: 8)),
                  Text("$date",
                      style: GoogleFonts.poppins(
                          color: active ? Colors.black : Colors.grey[600],
                          fontWeight:
                              active ? FontWeight.bold : FontWeight.normal,
                          fontSize: 20))
                ])));
  }
}
