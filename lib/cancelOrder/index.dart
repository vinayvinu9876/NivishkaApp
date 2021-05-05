import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:provider/provider.dart';
import 'CancelOrderModel.dart';

class CancelOrder extends StatefulWidget {
  final int orderId;
  CancelOrder({@required this.orderId});
  @override
  State<CancelOrder> createState() => _CancelOrder();
}

class _CancelOrder extends State<CancelOrder> {
  @override
  void initState() {
    super.initState();
    var cancelOrderModel =
        Provider.of<CancelOrderModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isEmpty(widget.orderId)) {
        Navigator.pop(context);
        return;
      }
      cancelOrderModel.setOrderId(widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var cancelOrderModel = Provider.of<CancelOrderModel>(context);

    bool isContinueActive = true;

    if (cancelOrderModel.cancellationReason == null) {
      isContinueActive = false;
    }
    if (cancelOrderModel.refundSpeed == null) {
      isContinueActive = false;
    }

    return SafeArea(
        top: true,
        bottom: true,
        left: true,
        right: true,
        child: Scaffold(
          bottomNavigationBar: InkWell(
              onTap: () {
                if ((!cancelOrderModel.isLoading) && (isContinueActive))
                  cancelOrderModel.cancelOrder();
              },
              child: Container(
                  padding: EdgeInsets.all(15),
                  color:
                      isContinueActive ? Colors.green[600] : Colors.grey[400],
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                            visible: !cancelOrderModel.isLoading,
                            child: Text("Continue",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 16))),
                        Visibility(
                          visible: cancelOrderModel.isLoading,
                          child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white)),
                        )
                      ]))),
          appBar: AppBar(
              backgroundColor: Colors.green[600],
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: Colors.white)),
              title: Text("Cancel Order",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16,
                  ))),
          body: Container(
              height: height,
              width: width,
              padding: EdgeInsets.all(15),
              child: ListView(children: [
                chooseReason(),
                SizedBox(height: 20),
                chooseRefundSpeed(),
                SizedBox(height: 20)
              ])),
        ));
  }

  Widget chooseRefundSpeed() {
    var cancelOrderModel = Provider.of<CancelOrderModel>(context);

    String refundVal = cancelOrderModel.refundSpeed;

    void onChange(String val) {
      cancelOrderModel.setRefundSpeed(val);
    }

    List<Map<String, String>> options = [
      {"name": "Normal in 3-5days", "value": "normal"},
      {"name": "Instant with charges", "value": "optimum"},
    ];
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          SizedBox(height: 10),
          Text("Refund Speed",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          for (Map<String, String> opt in options)
            option(
                name: opt["name"],
                val: opt["value"],
                active: (opt["value"] == refundVal),
                onChange: onChange),
        ]));
  }

  Widget chooseReason() {
    var cancelOrderModel = Provider.of<CancelOrderModel>(context);

    String cancellationVal = cancelOrderModel.cancellationReason;

    void onChange(String val) {
      cancelOrderModel.setCancellationReason(val);
    }

    List<String> options = [
      "I Changed my mind",
      "My schedule changed",
      "I chose the alternative"
    ];

    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          SizedBox(height: 20),
          Text("Please Tell us the reason",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text("Cancellation charges will be applicable",
              style: GoogleFonts.poppins(
                color: Colors.grey[600],
                fontSize: 10,
              )),
          SizedBox(height: 10),
          for (var opt in options)
            option(
                name: opt,
                val: opt,
                active: opt == cancellationVal,
                onChange: onChange)
        ]));
  }

  Widget option(
      {@required String name,
      @required String val,
      @required Function(String) onChange,
      bool active = false}) {
    return InkWell(
        onTap: () {
          onChange(val);
        },
        child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: active ? Colors.green[600] : Colors.white24,
              border: Border.all(
                  width: 1.0,
                  color: active ? Colors.green[600] : Colors.black45),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(children: [
              SizedBox(width: 10),
              Text("$name",
                  style: GoogleFonts.poppins(
                      color: active ? Colors.white : Colors.black45)),
            ])));
  }
}
