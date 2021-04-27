import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:styled_text/styled_text.dart';
import 'package:provider/provider.dart';
import 'ReceiptModel.dart';

class PromoList extends StatefulWidget {
  @override
  State<PromoList> createState() => _PromoList();
}

class _PromoList extends State<PromoList> {
  @override
  @protected
  void initState() {
    super.initState();
    var receiptModel = Provider.of<ReceiptModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      receiptModel.getPromoData();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var receiptModel = Provider.of<ReceiptModel>(context);
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            backgroundColor: Colors.grey[200],
            bottomNavigationBar: CustomBottomNavBar(selectedIndex: 0),
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                centerTitle: true,
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back, color: Colors.green[800])),
                title: Text("Promos",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black))),
            body: Container(
                height: height,
                width: width,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ListView(children: [
                  SizedBox(height: 10),
                  Visibility(
                      visible: (receiptModel.errorMessage != null),
                      child: Text(
                          receiptModel.errorMessage == null
                              ? ""
                              : receiptModel.errorMessage,
                          style: GoogleFonts.poppins(
                              color: Colors.red, fontSize: 12))),
                  Visibility(
                      visible: receiptModel.isPromoLoading,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(children: [CircularProgressIndicator()]),
                      )),
                  for (var promo in receiptModel.promoData)
                    promoWidget(promoData: promo),
                ]))));
  }

  Widget promoWidget({@override Map<String, dynamic> promoData}) {
    var receiptModel = Provider.of<ReceiptModel>(context);
    return Visibility(
        visible: !receiptModel.isPromoLoading,
        child: Container(
            height: 160,
            margin: EdgeInsets.only(top: 7, bottom: 7),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey, width: 0.5)),
            child: Column(children: [
              Expanded(
                  flex: 7,
                  child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 3,
                                child: StyledText(
                                    text:
                                        "<big>${promoData["isPercentDiscount"] ? promoData["percentageDiscount"].toString() + "%" : "₹" + promoData["max_discount_rupees"].toString()}</big> <sup>OFF</sup>",
                                    styles: {
                                      "big": GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      "sup": GoogleFonts.poppins(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold,
                                      )
                                    })),
                            Expanded(
                                flex: 6,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${promoData["promo_name"]}",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 12)),
                                      SizedBox(height: 8),
                                      Text("Coupon code",
                                          style: GoogleFonts.poppins(
                                            color: Colors.grey,
                                            fontSize: 10,
                                          )),
                                      Text(
                                          "#${promoData["promo_code"].toUpperCase()}",
                                          style: GoogleFonts.poppins(
                                            color: Colors.greenAccent[700],
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ])),
                            Expanded(
                                child: Container(
                                    child:
                                        Icon(Icons.chevron_right, color: blue)))
                          ]))),
              Expanded(
                  flex: 3,
                  child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.green[600],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StyledText(
                                text:
                                    "<all>Valid till <b>${promoData["end_date"].toDate().day.toString() + "-" + promoData["end_date"].toDate().month.toString() + "-" + promoData["end_date"].toDate().year.toString()}</b></all>",
                                styles: {
                                  "all": GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                  "b": GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold)
                                }),
                            Container(
                                child: Row(children: [
                              InkWell(
                                  onTap: () {
                                    receiptModel
                                        .setPromoCode(promoData["promo_id"]);
                                  },
                                  child: Text("Apply",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 12))),
                            ]))
                          ])))
            ])));
  }
}
