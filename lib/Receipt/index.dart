import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:provider/provider.dart';
import 'ReceiptModel.dart';
import 'PromoList.dart';

class Receipt extends StatefulWidget {
  final String categoryName;
  final Map<String, dynamic> cartData;
  Receipt({@required this.categoryName, @required this.cartData});
  @override
  State<Receipt> createState() =>
      _Receipt(categoryName: categoryName, cartData: cartData);
}

class _Receipt extends State<Receipt> {
  final String categoryName;
  final Map<String, dynamic> cartData;
  _Receipt({@required this.categoryName, @required this.cartData});

  @override
  @protected
  void initState() {
    super.initState();
    var receiptModel = Provider.of<ReceiptModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      receiptModel.setCartData(cartData);
    });
  }

  void doDisposeAll() {
    var receiptModel = Provider.of<ReceiptModel>(context, listen: false);
    receiptModel.onDispose();
    print("Called dispose");
  }

  Future<bool> onWillPop() async {
    doDisposeAll();
    return true;
  }

  String getDiscountInString() {
    var receiptModel = Provider.of<ReceiptModel>(context, listen: false);
    if (receiptModel.selectedPromoCodeData == null ||
        receiptModel.selectedPromoCodeData.keys.length == 0) {
      return null;
    }
    double cartValue = getCartValue();
    double deducted = 0;
    if (cartValue < receiptModel.selectedPromoCodeData["min_receipt_value"]) {
      return "0 (Min Cart Value ${receiptModel.selectedPromoCodeData["min_receipt_value"]})";
    }
    if (!receiptModel.selectedPromoCodeData["isPercentDiscount"]) {
      return "-${receiptModel.selectedPromoCodeData["max_discount_rupees"].toInt().toString()}";
    } else {
      double percentValue = cartValue *
          (receiptModel.selectedPromoCodeData["percentageDiscount"] / 100);

      if (percentValue >
          receiptModel.selectedPromoCodeData["max_discount_rupees"]) {
        deducted = receiptModel.selectedPromoCodeData["max_discount_rupees"];
      } else {
        deducted = percentValue;
      }
      return "- ${deducted.toInt()}";
    }
  }

  int getDiscountValue() {
    var receiptModel = Provider.of<ReceiptModel>(context, listen: false);
    if (receiptModel.selectedPromoCodeData == null ||
        receiptModel.selectedPromoCodeData.keys.length == 0) {
      return 0;
    }
    var cartValue = getCartValue();
    dynamic deducted = 0;
    if (cartValue < receiptModel.selectedPromoCodeData["min_receipt_value"]) {
      return 0;
    }
    if (!receiptModel.selectedPromoCodeData["isPercentDiscount"]) {
      return receiptModel.selectedPromoCodeData["max_discount_rupees"];
    } else {
      var percentValue = cartValue *
          (receiptModel.selectedPromoCodeData["percentageDiscount"] / 100);

      if (percentValue >
          receiptModel.selectedPromoCodeData["max_discount_rupees"]) {
        deducted = receiptModel.selectedPromoCodeData["max_discount_rupees"]
            .toDouble();
      } else {
        deducted = percentValue;
      }
      return deducted.toInt();
    }
  }

  double getCartValue() {
    var receiptModel = Provider.of<ReceiptModel>(context, listen: false);
    double total = 0;
    receiptModel.cartData.keys.forEach((String key) {
      Map<String, dynamic> itemData = receiptModel.cartData[key];
      int totalValue = itemData["partner_cost"] + itemData["charges"];
      double discount = (itemData["discount"] / 100) * totalValue;
      print("Discount Percentage = $discount");
      double newTotal = (totalValue - discount) * itemData["no_of_items"];
      total += newTotal;
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var receiptModel = Provider.of<ReceiptModel>(context);
    return SafeArea(
        top: true,
        bottom: true,
        child: new WillPopScope(
            onWillPop: onWillPop,
            child: Scaffold(
                backgroundColor: Colors.white,
                bottomNavigationBar: checkoutButton(),
                appBar: AppBar(
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    elevation: 3,
                    leading: InkWell(
                        onTap: () {
                          doDisposeAll();
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back,
                            color: Colors.black, size: 16)),
                    title: Text("$categoryName",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 14))),
                body: Container(
                    height: height,
                    width: width,
                    child: ListView(children: [
                      Container(
                          child: Column(children: [
                        for (var key in receiptModel.cartData.keys)
                          Container(
                              child: Column(children: [
                            itemPrice(itemData: cartData[key]),
                            Container(
                                padding: EdgeInsets.only(
                                    top: 5, bottom: 0, left: 15, right: 15),
                                child: Container(
                                  height: 1,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                  ),
                                ))
                          ])),
                      ])),
                      Container(height: 15, color: Colors.grey[100]),
                      promoCodeLinkWidget(),
                      Container(height: 15, color: Colors.grey[100]),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                itemPriceList(
                                    name: "Item Total",
                                    price: "${getCartValue()}"),
                                itemPriceList(
                                    name: "Convenience & other charges [+]",
                                    price: "${receiptModel.charges}"),
                                Visibility(
                                    visible: receiptModel
                                            .selectedPromoCodeData.keys.length >
                                        0,
                                    child: itemPriceList(
                                        name: "Promo discount",
                                        price: "${getDiscountInString()}")),
                                SizedBox(height: 10),
                                Container(
                                  height: 2,
                                  width: width,
                                  color: Colors.grey[100],
                                ),
                                itemPriceList(
                                    name: "Total",
                                    price:
                                        "${getCartValue() - (getDiscountValue()) + receiptModel.charges}",
                                    isTotal: true),
                              ]))
                    ])))));
  }

  Widget promoCodeLinkWidget() {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PromoList()),
          );
        },
        child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border:
                                    Border.all(width: 1, color: Colors.black)),
                            child: Center(
                                child: Text("%",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16)))),
                        SizedBox(width: 10),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Offers, promo code and gift cards",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 10,
                                  )),
                            ])
                      ])),
                  Container(
                      child: Icon(Icons.chevron_right, color: Colors.grey[600]))
                ])));
  }

  Widget checkoutButton() {
    var receiptModel = Provider.of<ReceiptModel>(context);
    double width = MediaQuery.of(context).size.width;

    return Container(
        height: receiptModel.errorMessage == null ? 70 : 112,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.green[800], boxShadow: [
          BoxShadow(
            color: Colors.grey,
          ),
        ]),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Visibility(
                  visible: receiptModel.errorMessage != null,
                  child: Container(
                      color: receiptModel.errorMessage == null
                          ? Colors.green[800]
                          : Colors.white,
                      padding: EdgeInsets.all(15),
                      width: width,
                      child: Text("${receiptModel.errorMessage}",
                          style: GoogleFonts.poppins(
                              color: Colors.red, fontSize: 12)))),
              InkWell(
                  onTap: () {
                    if ((receiptModel.cartData.length > 0) &&
                        (!receiptModel.isLoading)) receiptModel.createOrder();
                  },
                  child: Container(
                      height: receiptModel.errorMessage == null ? 50 : 64,
                      padding: EdgeInsets.only(
                          left: 20, right: 10, top: 5, bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.green[800],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Visibility(
                                      visible: (!receiptModel.isLoading),
                                      child: Container(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                            SizedBox(width: 10),
                                            Text(
                                                "₹ ${getCartValue() - (getDiscountValue()) + receiptModel.charges}",
                                                style: GoogleFonts.roboto(
                                                  color: Colors.white,
                                                ))
                                          ]))),
                                  Container(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        Text(
                                            receiptModel.isLoading
                                                ? "Processing..."
                                                : "Continue",
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: Colors.white,
                                            )),
                                        Visibility(
                                            visible: (!receiptModel.isLoading),
                                            child: Icon(
                                                Icons.keyboard_arrow_right,
                                                color: Colors.white))
                                      ]))
                                ])
                          ])))
            ]));
  }

  Widget itemPriceList(
      {@required String name, @required String price, bool isTotal = false}) {
    FontWeight weight = isTotal ? FontWeight.bold : FontWeight.normal;
    double fontSize = isTotal ? 12 : 10;
    Color color = isTotal ? Colors.black : Colors.grey[600];
    return Container(
        margin: EdgeInsets.all(5),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("$name",
                  style: GoogleFonts.poppins(
                      color: color, fontSize: fontSize, fontWeight: weight)),
              Text("₹ $price",
                  style: GoogleFonts.roboto(
                      color: color, fontSize: fontSize, fontWeight: weight))
            ]));
  }

  Widget itemPrice({@required Map<String, dynamic> itemData}) {
    double total = (itemData["partner_cost"] + itemData["charges"]).toDouble();
    double discount = (total * (itemData["discount"] / 100));
    int totalWithDiscount = (total - discount).toInt();
    var receiptModel = Provider.of<ReceiptModel>(context);

    int noOfItems =
        receiptModel.cartData[itemData["service_id"].toString()]["no_of_items"];

    totalWithDiscount = totalWithDiscount * noOfItems;
    total = total * noOfItems;

    return Container(
        padding: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${itemData["service_name"]}",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(height: 5),
                    Container(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          for (String i in itemData["service_description"])
                            Bullet("$i",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey[500],
                                  fontSize: 10,
                                )),
                        ]))
                  ]),
              SizedBox(height: 15),
              Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                            child: Row(children: [
                          Text("₹$totalWithDiscount",
                              style: GoogleFonts.roboto(
                                  color: Colors.black, fontSize: 12)),
                          SizedBox(width: 5),
                          Visibility(
                              visible: discount > 0,
                              child: Text("₹$total", // striked text
                                  style: GoogleFonts.roboto(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey[500],
                                      fontSize: 10)))
                        ]))),
                    Container(
                      width: 80,
                      child: counter(itemData: itemData),
                    )
                  ]))
            ]));
  }

  Widget counter({@required Map<String, dynamic> itemData}) {
    var receiptModel = Provider.of<ReceiptModel>(context);

    int noOfItems =
        receiptModel.cartData[itemData["service_id"].toString()]["no_of_items"];

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Colors.green[800]),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        receiptModel
                            .removeFromCart(itemData["service_id"].toString());
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green[800],
                          ),
                          child: Center(
                              child: Text("-",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white,
                                  )))))),
              Expanded(
                  flex: 1,
                  child: Container(
                      color: Colors.white,
                      child: Center(
                          child: Text(" $noOfItems ",
                              style: GoogleFonts.poppins(
                                  color: Colors.green, fontSize: 10))))),
              Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        receiptModel
                            .addToCart(itemData["service_id"].toString());
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green[800],
                          ),
                          child: Center(
                              child: Text("+",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white,
                                  )))))),
            ]));
  }
}

class Bullet extends Text {
  const Bullet(
    String data, {
    Key key,
    TextStyle style,
    TextAlign textAlign,
    TextDirection textDirection,
    Locale locale,
    bool softWrap,
    TextOverflow overflow,
    double textScaleFactor,
    int maxLines,
    String semanticsLabel,
  }) : super(
          '•   ${data}',
          key: key,
          style: style,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
        );
}
