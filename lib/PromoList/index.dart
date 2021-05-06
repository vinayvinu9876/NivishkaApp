import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:styled_text/styled_text.dart';
import 'PromoListModel.dart';
import 'package:provider/provider.dart';
import 'package:nivishka_android/PromoDescription/index.dart';

class PromoList extends StatefulWidget {
  @override
  State<PromoList> createState() => _PromoList();
}

class _PromoList extends State<PromoList> {
  @override
  void initState() {
    super.initState();
    var promoDescModel = Provider.of<PromoListModel>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => promoDescModel.getPromoList());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var promoDescModel = Provider.of<PromoListModel>(context);
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
                      Navigator.pushNamed(context, "/home");
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
                child: Column(children: [
                  Visibility(
                      visible: (promoDescModel.errorMessage != null),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          height: 100,
                          width: width,
                          child: Text("${promoDescModel.errorMessage}",
                              style: GoogleFonts.poppins(
                                  color: Colors.red, fontSize: 12)))),
                  Visibility(
                      visible: (promoDescModel.isLoading),
                      child: Expanded(
                          child: Container(
                              child:
                                  Center(child: CircularProgressIndicator())))),
                  Visibility(
                      visible: (!promoDescModel.isLoading),
                      child: Expanded(
                          child: ListView(children: [
                        SizedBox(height: 10),
                        for (var i in promoDescModel.promoList)
                          promoWidget(
                              offerText: "₹ ${i["max_discount_rupees"]}",
                              desc: "${i["promo_name"]}",
                              promoId: i["promo_id"],
                              couponCode: "${i["promo_code"]}",
                              validTill: i["end_date"].toDate()),
                      ])))
                ]))));
  }

  Widget promoWidget({
    @override String offerText,
    @override int promoId,
    @override String desc,
    @override String couponCode,
    @override DateTime validTill,
  }) {
    String date = "";

    date = "${validTill.day}-${validTill.month + 1}-${validTill.year}";

    return Container(
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
                                text: "<big>$offerText</big> <sup>OFF</sup>",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("$desc",
                                      style: GoogleFonts.poppins(
                                          color: Colors.black, fontSize: 12)),
                                  SizedBox(height: 8),
                                  Text("Coupon code",
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      )),
                                  Text("$couponCode",
                                      style: GoogleFonts.poppins(
                                        color: Colors.greenAccent[700],
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ])),
                        Expanded(
                            child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PromoDescription(
                                              promoId: promoId,
                                            )),
                                  );
                                },
                                child: Container(
                                    child: Icon(Icons.chevron_right,
                                        color: blue))))
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
                            text: "<all>Valid till <b>$date</b></all>",
                            styles: {
                              "all": GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              "b": GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold)
                            }),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PromoDescription(
                                          promoId: promoId,
                                        )),
                              );
                            },
                            child: Container(
                                child: Row(children: [
                              Text("Details",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 12)),
                              SizedBox(width: 5),
                              Icon(Icons.keyboard_arrow_down,
                                  size: 20, color: Colors.white)
                            ])))
                      ])))
        ]));
  }
}
