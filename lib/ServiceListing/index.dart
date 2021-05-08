import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:nivishka_android/Receipt/index.dart';
import 'package:provider/provider.dart';
import 'ServiceListingModel.dart';
import 'dart:math' as math;

class ServiceListing extends StatefulWidget {
  final String categoryID, catName;
  final int scrollToSubCatId;
  ServiceListing(
      {@required this.categoryID,
      @required this.catName,
      @required this.scrollToSubCatId});
  @override
  State<ServiceListing> createState() => _ServiceListing(
      categoryID: categoryID,
      catName: catName,
      scrollToSubCatId: scrollToSubCatId);
}

class _ServiceListing extends State<ServiceListing> {
  final String categoryID, catName;
  final int scrollToSubCatId;
  _ServiceListing(
      {@required this.categoryID,
      @required this.catName,
      @required this.scrollToSubCatId});

  final random = math.Random();
  final scrollDirection = Axis.vertical;
  int currentIndex = 1;
  bool scrolledToInitialIndex = false;

  AutoScrollController controller;
  List<List<int>> randomList;

  @override
  @protected
  void initState() {
    super.initState();
    var serviceListModel =
        Provider.of<ServiceListingModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      serviceListModel.callEverything(categoryID);
    });

    controller = AutoScrollController(
        viewportBoundaryGetter: () =>
            Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
        axis: scrollDirection);
  }

  void killAll() {
    var serviceListModel =
        Provider.of<ServiceListingModel>(context, listen: false);
    serviceListModel.killAllSubscriptions();
  }

  double getServiceCost(Map<String, dynamic> serviceData) {
    int total = serviceData["partner_cost"] + serviceData["charges"];
    double discount = (total) * (serviceData["discount"] / 100);
    return ((total - discount));
  }

  Future _scrollToIndex(int index) async {
    await controller.scrollToIndex(index,
        duration: Duration(milliseconds: 500),
        preferPosition: AutoScrollPosition.begin);
    controller.highlight(index);
  }

  @override
  Widget build(BuildContext context) {
    var serviceListModel = Provider.of<ServiceListingModel>(context);
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
        top: true,
        child: Scaffold(
            bottomNavigationBar: Visibility(
                visible: (serviceListModel.cartData.keys.length > 0),
                child: checkoutButton()),
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
                elevation: 4,
                backgroundColor: Colors.white,
                centerTitle: true,
                leading: InkWell(
                    onTap: () {
                      killAll();
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
                title: Text("$catName",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.black,
                    ))),
            body: Column(children: [
              categoryList(),
              Expanded(
                  child: Container(
                      child: ListView(
                          scrollDirection: scrollDirection,
                          controller: controller,
                          children: [
                    SizedBox(height: 10),
                    for (var item in serviceListModel.subCategoryData)
                      if (serviceListModel.servicesData
                          .containsKey(item["sub_cat_id"].toString()))
                        AutoScrollTag(
                            key: ValueKey(item["sub_cat_id"]),
                            controller: controller,
                            index: item["sub_cat_id"],
                            highlightColor: Colors.black.withOpacity(0.1),
                            child: Container(
                                width: width,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${item["cat_name"]}",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      SizedBox(height: 10),
                                      for (var service
                                          in serviceListModel.servicesData[
                                              item["sub_cat_id"].toString()])
                                        serviceItem(serviceData: service),
                                      SizedBox(height: 10),
                                    ]))),
                  ])))
            ])));
  }

  Widget checkoutButton() {
    var serviceListModel = Provider.of<ServiceListingModel>(context);
    int totalServices = 0;
    double totalValue = 0;

    serviceListModel.cartData.keys.forEach((key) {
      totalValue += (getServiceCost(serviceListModel.cartData[key]) *
          (serviceListModel.cartData[key]["no_of_items"]));
      totalServices += serviceListModel.cartData[key]["no_of_items"];
    });

    return Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
          ),
        ]),
        padding: EdgeInsets.all(15),
        child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Receipt(
                    categoryName: catName, cartData: serviceListModel.cartData);
              }));
            },
            child: Container(
                height: 50,
                padding:
                    EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.green[800],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                            Container(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 2, bottom: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border:
                                      Border.all(width: 1, color: Colors.white),
                                ),
                                child: Text("$totalServices",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ))),
                            SizedBox(width: 10),
                            Text("₹ $totalValue",
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                ))
                          ])),
                      Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text("Continue",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.white,
                                )),
                            Icon(Icons.keyboard_arrow_right,
                                color: Colors.white)
                          ]))
                    ]))));
  }

  Widget serviceItem({@required Map<String, dynamic> serviceData}) {
    int totalCost = serviceData["partner_cost"] + serviceData["charges"];
    double discountMoney = (serviceData["discount"] / 100) * totalCost;
    int offerPrice = (totalCost - discountMoney).toInt();
    return Card(
        elevation: 0,
        child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            "${serviceData["imageUrl"]}"))))),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 5,
                          child: Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text("${serviceData["service_name"]}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Color(0xFF252525),
                                      fontWeight: FontWeight.w500,
                                    )),
                                SizedBox(height: 5),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.green[800],
                                      ),
                                      SizedBox(width: 3),
                                      Text("${serviceData["ratings"]}",
                                          style: GoogleFonts.poppins(
                                              color: Colors.green[800],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12)),
                                      SizedBox(width: 5),
                                      Text("${serviceData["total_raters"]}",
                                          style: GoogleFonts.poppins(
                                              color: Colors.grey[500],
                                              fontSize: 10))
                                    ]),
                                SizedBox(height: 3),
                                Text("₹ $offerPrice",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black, fontSize: 12)),
                                Visibility(
                                    visible: discountMoney > 0,
                                    child: Text("₹ $totalCost",
                                        style: GoogleFonts.poppins(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: Colors.black,
                                            fontSize: 10))),
                              ])),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                              child: Container(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                SizedBox(height: 15),
                                counter(
                                  serviceId:
                                      serviceData["service_id"].toString(),
                                  serviceData: serviceData,
                                ),
                              ]))),
                        )
                      ]),
                  SizedBox(height: 15),
                  Visibility(
                      visible: serviceData["service_description"].length > 0,
                      child: Container(height: 1, color: Colors.grey[100])),
                  Visibility(
                      visible: serviceData["service_description"].length > 0,
                      child: SizedBox(height: 10)),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (String serviceDescription
                            in serviceData["service_description"])
                          Container(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              child: Bullet("$serviceDescription",
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[500],
                                    fontSize: 10,
                                  ))),
                      ])
                ])));
  }

  Widget counter(
      {@required String serviceId,
      @required Map<String, dynamic> serviceData}) {
    var serviceListModel = Provider.of<ServiceListingModel>(context);

    int noOfItems = 0;

    if (serviceListModel.cartData.containsKey(serviceId)) {
      noOfItems = serviceListModel.cartData[serviceId]["no_of_items"];
    } else {
      noOfItems = 0;
    }

    return Container(
        width: 87,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Colors.green),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    serviceListModel.removeFromCart(serviceId);
                  },
                  child: Container(
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.green[600],
                      ),
                      child: Center(
                          child: Text("-",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                              ))))),
              Container(
                  width: 25,
                  color: Colors.white,
                  child: Center(
                      child: Text(" $noOfItems ",
                          style: GoogleFonts.poppins(
                              color: Colors.green[800], fontSize: 10)))),
              InkWell(
                  onTap: () {
                    serviceListModel.addToCart(serviceId, serviceData);
                  },
                  child: Container(
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.green[600],
                      ),
                      child: Center(
                          child: Text("+",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                              ))))),
            ]));
  }

  Widget categoryList() {
    var serviceListModel = Provider.of<ServiceListingModel>(context);
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: ListView(scrollDirection: Axis.horizontal, children: [
          for (var item in serviceListModel.subCategoryData)
            InkWell(
                onTap: () {
                  _scrollToIndex(item["sub_cat_id"]);
                  setState(() {
                    currentIndex = item["sub_cat_id"];
                  });
                },
                child: categoryListWidget(
                    name: "${item["cat_name"]}",
                    active: (item["sub_cat_id"] == currentIndex))),
        ]));
  }

  Widget categoryListWidget({@required String name, bool active = false}) {
    return Container(
        margin: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: active ? Colors.green[600] : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(width: 1, color: active ? primaryColor : Colors.black),
        ),
        padding: EdgeInsets.all(10),
        child: Text("$name",
            style: GoogleFonts.poppins(
                color: active ? Colors.white : Colors.black, fontSize: 12)));
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
