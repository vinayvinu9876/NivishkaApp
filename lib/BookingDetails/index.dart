import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:provider/provider.dart';
import 'package:nivishka_android/cancelOrder/index.dart';
import 'BookingDetailsModel.dart';

class BookingDetails extends StatefulWidget {
  final Map<String, dynamic> orderDetails;
  BookingDetails({@required this.orderDetails});
  @override
  State<BookingDetails> createState() => _BookingDetails();
}

class _BookingDetails extends State<BookingDetails> {
  @override
  void initState() {
    super.initState();
    var bookingDetailsModel =
        Provider.of<BookingDetailsModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingDetailsModel.getData(widget.orderDetails["order_id"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var bookingDetailsModel = Provider.of<BookingDetailsModel>(context);
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            bottomNavigationBar: bottomNavBar(),
            body: Container(
              height: height,
              width: width,
              child: ListView(children: [
                topBar(),
                SizedBox(height: 10),
                serviceTimeAndLocation(),
                billDetails(),
                Visibility(
                    visible: bookingDetailsModel.partnerData != null,
                    child: partnerDetails()),
                Container(
                    child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: Visibility(
                        visible: bookingDetailsModel.paymentData != null,
                        child: paymentDetails()),
                  ),
                  Expanded(
                    flex: 1,
                    child: Visibility(
                        visible: bookingDetailsModel.refundData != null,
                        child: refundDetails()),
                  )
                ])),
              ]),
            )));
  }

  Widget refundDetails() {
    Widget keyValue({@required String key, @required String value}) {
      return Container(
          padding: EdgeInsets.only(top: 3, bottom: 3),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$key",
                    style: GoogleFonts.poppins(
                        color: Colors.grey[500], fontSize: 10)),
                SizedBox(height: 1),
                Text("$value",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w500))
              ]));
    }

    var bookingDetailsModel = Provider.of<BookingDetailsModel>(context);

    int amount = 0;
    String status = "";
    String speed = "";

    if (bookingDetailsModel.refundData != null) {
      amount = (bookingDetailsModel.refundData["amount"] / 100).toInt();
      status = bookingDetailsModel.refundData["status"];
      speed = bookingDetailsModel.refundData["speed_processed"] == "normal"
          ? "Within 4-5days"
          : "Instant";
    }

    return Container(
        padding: EdgeInsets.all(
          10,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Refund Details",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              keyValue(key: "Refund Amount", value: "₹ $amount"),
              keyValue(key: "Refund Status", value: "$status"),
              keyValue(key: "Refund Speed", value: "$speed"),
            ]));
  }

  Widget paymentDetails() {
    Widget keyValue({@required String key, @required String value}) {
      return Container(
          padding: EdgeInsets.only(top: 3, bottom: 3),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$key",
                    style: GoogleFonts.poppins(
                        color: Colors.grey[500], fontSize: 10)),
                SizedBox(height: 1),
                Text("$value",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w500))
              ]));
    }

    var bookingDetailsModel = Provider.of<BookingDetailsModel>(context);

    Map<String, dynamic> paymentData = bookingDetailsModel.paymentData;

    String paymentAmount = "";
    String paymentMethod = "";
    String status = "";
    String paymentDetails = "";

    if (paymentData != null) {
      paymentAmount = (paymentData["payment_amount"] / 100).toString();
      paymentMethod = paymentData["payment_method"];
      status = paymentData["status"];
      if (paymentData["bank"] != null) {
        paymentDetails = paymentData["bank"];
      } else if (paymentData["card_id"] != null) {
        paymentDetails = paymentData["card_id"];
      } else if (paymentData["vpa"] != null) {
        paymentDetails = paymentData["vpa"];
      } else if (paymentData["wallet"] != null) {
        paymentDetails = paymentData["wallet"];
      }
    }

    return Container(
        padding: EdgeInsets.all(
          10,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Payment Details",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              keyValue(key: "Payment Amount", value: "₹ $paymentAmount"),
              keyValue(
                  key: "Payment Method",
                  value: "$paymentMethod $paymentDetails"),
              keyValue(key: "Payment Status", value: "$status"),
            ]));
  }

  Widget bottomNavBar() {
    double width = MediaQuery.of(context).size.width;

    bool isCancelButton = false;

    if ((["paid", "partner_alloted"].contains(widget.orderDetails["status"]))) {
      isCancelButton = true;
    }

    return Container(
        width: width,
        padding: EdgeInsets.all(15),
        child: Row(children: [
          Expanded(
              flex: 5,
              child: InkWell(
                  onTap: () {
                    if (isCancelButton)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CancelOrder(
                                orderId: widget.orderDetails["order_id"])),
                      );
                  },
                  child: Container(
                      height: 40,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.topCenter,
                            colors: gradient,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Center(
                          child: Text(
                              isCancelButton ? "Cancel" : "Rate Service",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)))))),
          SizedBox(width: 10),
          Expanded(
              flex: 5,
              child: Container(
                  height: 40,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.topCenter,
                        colors: gradient,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Center(
                      child: Text("Need Help",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500))))),
        ]));
  }

  Widget partnerDetails() {
    Widget keyValue({@required String key, @required String value}) {
      return Container(
          padding: EdgeInsets.only(top: 3, bottom: 3),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$key",
                    style: GoogleFonts.poppins(
                        color: Colors.grey[500], fontSize: 10)),
                SizedBox(height: 1),
                Text("$value",
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w500))
              ]));
    }

    var bookingDetailsModel = Provider.of<BookingDetailsModel>(context);

    String imgUrl = bookingDetailsModel.partnerData == null
        ? "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"
        : bookingDetailsModel.partnerData["imgUrl"];
    String name = bookingDetailsModel.partnerData == null
        ? ""
        : bookingDetailsModel.partnerData["name"];

    String phone = bookingDetailsModel.partnerData == null
        ? ""
        : bookingDetailsModel.partnerData["phone"];

    String partnerId = bookingDetailsModel.partnerData == null
        ? ""
        : bookingDetailsModel.partnerData["partner_id"].toString();

    return Container(
        padding: EdgeInsets.all(
          10,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Partner Details",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 10),
              Container(
                  height: 120,
                  child: Row(children: [
                    Expanded(
                        flex: 3,
                        child: Image(
                            height: 120,
                            fit: BoxFit.cover,
                            image: NetworkImage("$imgUrl"))),
                    SizedBox(width: 15),
                    Expanded(
                        flex: 7,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              keyValue(
                                  key: "Partner number",
                                  value: "NIVPART$partnerId"),
                              keyValue(key: "Partner Name", value: "$name"),
                              keyValue(key: "Phone", value: "$phone"),
                            ]))
                  ])),
            ]));
  }

  Widget billDetails() {
    Widget itemValue(
        {@required String key, @required String value, bool bold = false}) {
      return Container(
          padding: EdgeInsets.all(5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$key",
                    style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.black87,
                        fontWeight:
                            bold ? FontWeight.bold : FontWeight.normal)),
                Text("₹ $value",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w600))
              ]));
    }

    Map<String, dynamic> cartData = widget.orderDetails["cartData"];

    double total = 0;

    cartData.keys.forEach((key) {
      var subtotal = cartData[key]["charges"] + cartData[key]["partner_cost"];
      double discount = (subtotal * (cartData[key]["discount"] / 100));
      total += (subtotal - discount);
    });

    total += widget.orderDetails["other_charges"];
    total -= widget.orderDetails["discount"];

    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: Colors.grey[500]),
              for (var key in cartData.keys)
                itemValue(
                    key: cartData[key]["service_name"],
                    value: ((cartData[key]["partner_cost"] +
                                cartData[key]["charges"]) -
                            ((cartData[key]["partner_cost"] +
                                    cartData[key]["charges"]) *
                                (cartData[key]["discount"] / 100)))
                        .toString()),
              itemValue(
                  key: "Other Charges",
                  value: "${widget.orderDetails["other_charges"]}"),
              Visibility(
                  visible: widget.orderDetails["discount"] > 0,
                  child: itemValue(
                      key: "Discount",
                      value: "- ${widget.orderDetails["discount"]}")),
              Divider(color: Colors.grey[500]),
              itemValue(key: "Total", value: "$total", bold: true),
            ]));
  }

  Widget serviceTimeAndLocation() {
    int d = widget.orderDetails["create_date"].toDate().day;
    String day;
    if (d % 10 == 1) {
      day = "$d st";
    } else if (d % 10 == 2) {
      day = "$d nd";
    } else {
      day = "$d th";
    }
    List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    String month =
        months[widget.orderDetails["create_date"].toDate().month - 1];
    String year = widget.orderDetails["create_date"].toDate().year.toString();

    String scheduleTime = "";

    if (widget.orderDetails["delivery_date_and_time"]["time"] != null) {
      int time = widget.orderDetails["delivery_date_and_time"]["time"];
      int hrs = (time ~/ 100).toInt();
      int mins = (time - (hrs * 100));
      if (time >= 1200 && time < 1300) {
        scheduleTime = "12: ${mins == 0 ? "00" : mins} pm";
      } else if (time >= 1300) {
        scheduleTime =
            "(${hrs - 12} : ${mins == 0 ? "00" : mins.toString()} pm";
      } else {
        scheduleTime = " $hrs : ${mins == 0 ? "00" : mins.toString()} am";
      }
    }
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Scheduled on $day $month $year at $scheduleTime",
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.black54,
                  )),
              SizedBox(height: 5),
              Text("${widget.orderDetails["deliveryLocation"]["placeName"]}",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  )),
            ]));
  }

  Widget topBar() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 120,
      width: width,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.topCenter,
            colors: gradient,
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15))),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back, color: Colors.black)),
            SizedBox(height: 10),
            Container(
                child: Row(children: [
              Container(
                  height: 45,
                  width: 45,
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Icon(Icons.home_repair_service,
                          size: 30, color: Colors.black))),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(7),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("NIV${widget.orderDetails["order_id"]}",
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                              "Service is ${widget.orderDetails["status"] == "paid" ? "scheduled" : widget.orderDetails["status"]}",
                              style: GoogleFonts.poppins(
                                  fontSize: 12, fontWeight: FontWeight.bold))
                        ])),
              )
            ]))
          ]),
    );
  }
}
