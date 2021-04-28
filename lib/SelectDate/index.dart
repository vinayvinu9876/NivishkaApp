import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'SelectDateModel.dart';

class SelectDate extends StatefulWidget {
  @override
  State<SelectDate> createState() => _SelectDate();
}

class _SelectDate extends State<SelectDate> {
  @override
  void initState() {
    super.initState();
    var selectDateModel = Provider.of<SelectDateModel>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => selectDateModel.getStartAndEndTime());
  }

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

    var selectDateModel = Provider.of<SelectDateModel>(context);

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
                title: Text("Select Date",
                    style: GoogleFonts.poppins(fontSize: 14))),
            body: Container(
                height: height,
                width: width,
                padding: EdgeInsets.all(10),
                child: ListView(children: [
                  SizedBox(
                    height: 15,
                  ),
                  Visibility(
                    visible: (selectDateModel.isLoading),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  Visibility(
                      visible: (!selectDateModel.isLoading),
                      child: Text(
                          "When would you like Nivishka Services to serve you?",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 14))),
                  Visibility(
                      visible: (!selectDateModel.isLoading),
                      child: SizedBox(height: 15)),
                  Visibility(
                      visible: (!selectDateModel.isLoading),
                      child: Text("Select date of service",
                          style: GoogleFonts.poppins(
                              color: Colors.grey[600], fontSize: 10))),
                  Visibility(
                      visible: (!selectDateModel.isLoading),
                      child: SizedBox(height: 10)),
                  Visibility(
                      visible: (!selectDateModel.isLoading),
                      child: selectDate()),
                  Visibility(
                      visible: (!selectDateModel.isLoading),
                      child: SizedBox(height: 10)),
                  Visibility(
                      visible: (!selectDateModel.isLoading),
                      child: Text("Select Time",
                          style: GoogleFonts.poppins(
                              color: Colors.grey[600], fontSize: 10))),
                  Visibility(
                      visible: (!selectDateModel.isLoading),
                      child: SizedBox(height: 10)),
                  Visibility(
                      visible: (!selectDateModel.isLoading),
                      child: timeSelection())
                ]))));
  }

  String getTime(int val) {
    String time = val.toString();
    String min = "0";
    String hrs = "0";
    String amORpm = "am";
    if (time.length == 3) {
      hrs = time[0];
      min = time.substring(1);
    } else if (time.length == 4) {
      hrs = time.substring(0, 2);
      min = time.substring(2);
    } else {
      print("Time length is neither 3 or 4 $time");
    }

    if (int.parse(hrs) == 12) {
      amORpm = "pm";
    }

    if (int.parse(hrs) > 12) {
      hrs = (int.parse(hrs) - 12).toString();
      amORpm = "pm";
    }
    return "$hrs : $min $amORpm";
  }

  Widget timeSelection() {
    var selectDateModel = Provider.of<SelectDateModel>(context);

    List<String> times = [];
    int i = selectDateModel.start;
    int diff = selectDateModel.diff;
    while (i <= selectDateModel.end) {
      int temp = i % 100;
      int val = i;
      if (temp == 0) {
        i = i + diff;
      } else if (temp == 60) {
        i = i + 40;
        val = i;
        i = i + diff;
      } else {
        i = i + diff;
      }
      String time = getTime(val);
      times.add(time);
    }

    return Container(
        child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            alignment: WrapAlignment.spaceBetween,
            runAlignment: WrapAlignment.center,
            children: [for (var time in times) timeWidget("$time")]));
  }

  Widget selectDate() {
    var selectDateModel = Provider.of<SelectDateModel>(context);
    List<Map<String, DateTime>> dates = [];

    for (int i = 0; i < 4; i++) {
      if (dates.length == 0) {
        dates.add({"Today": (new DateTime.now())});
      } else {
        DateTime temp = dates[dates.length - 1]
                [dates[dates.length - 1].keys.last]
            .add(Duration(days: 1));
        if (dates.length == 1) {
          dates.add({"Tommorow": temp});
        } else {
          String dayName = DateFormat('EEEE').format(temp);
          dates.add({dayName: temp});
        }
      }
    }
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          for (var date in dates)
            dateWidget("${date.keys.first}", "${date[date.keys.first].day}",
                date[date.keys.first],
                active: (date[date.keys.first].day ==
                    (selectDateModel.selectedDate == null
                        ? 0
                        : selectDateModel.selectedDate.day))),
        ]));
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

  Widget dateWidget(String title, String date, DateTime currDate,
      {bool active = false}) {
    var selectDateModel = Provider.of<SelectDateModel>(context, listen: false);
    return Expanded(
        flex: 1,
        child: InkWell(
            onTap: () {
              selectDateModel.setSelectedDate(currDate);
            },
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
                    ]))));
  }
}
