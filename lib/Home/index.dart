import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:nivishka_android/CategoryDescription/index.dart';
import 'package:styled_text/styled_text.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:nivishka_android/PromoDescription/index.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:nivishka_android/ServiceListing/index.dart';
import 'package:provider/provider.dart';
import "CustomDrawer.dart";
import "HomeModel.dart";

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    var homeModel = Provider.of<HomeModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print("At init home calling getAllData");
      homeModel.getAllData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    var homeModel = Provider.of<HomeModel>(context, listen: false);
    homeModel.cancelSubscriptions();
  }

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    var homeModel = Provider.of<HomeModel>(context);
    print(
        "isLoading = ${homeModel.isLoading} and length of promo = ${homeModel.promoData.length}");
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            key: _scaffoldKey,
            drawer: CustomDrawer(),
            bottomNavigationBar: CustomBottomNavBar(selectedIndex: 0),
            body: Container(
                child: ListView(children: [
              topAppBar(),
              SizedBox(height: 10),
              Visibility(
                  visible: (!homeModel.isLoading) &&
                      (homeModel.promoData.length > 0),
                  child: promo()),
              Visibility(
                  visible: (!homeModel.isLoading) &&
                      (homeModel.categoryData.length > 0),
                  child: category()),
              SizedBox(height: 10),
              Visibility(
                  visible: ((!homeModel.isLoading) &&
                      (homeModel.bestPicksData.length > 0)),
                  child: bestPicks()),
              //Visibility(visible: !homeModel.isLoading, child: flashSale()),
              //SizedBox(height: 5),
              Visibility(
                  visible: homeModel.isLoading,
                  child: Container(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      )))
            ]))));
  }

  Widget flashSale() {
    return Container(
        height: 150,
        padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StyledText(
                  text: "<p>Flash Sale</p> <red>( 10 mins remaining )</red>",
                  styles: {
                    "p": GoogleFonts.poppins(fontSize: 12, color: Colors.black),
                    "red": GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.red,
                    )
                  }),
              SizedBox(height: 10),
              Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    flashWidget(
                      desc: "Cleaning Service Tube Light hello",
                      imgUrl:
                          "https://res.cloudinary.com/urbanclap/image/upload/q_auto,f_auto,fl_progressive:steep,w_617/t_high_res_template,q_auto:low,f_auto/categories/category_v2/category_be519380.png",
                      val: 100,
                      total: 160,
                      sold: 120,
                    ),
                    flashWidget(
                      desc: "Haircut at home @low cost",
                      imgUrl:
                          "https://www.businessinsider.in/thumb.cms?msid=75749662&width=1200&height=900",
                      val: 500,
                      total: 100,
                      sold: 20,
                    ),
                    SizedBox(width: 5),
                  ])),
            ]));
  }

  Widget flashWidget({
    @required String desc,
    @required String imgUrl,
    @required double val,
    @required int total,
    @required int sold,
  }) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/flashSale");
        },
        child: Container(
            width: 220,
            margin: EdgeInsets.only(left: 7, right: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: Row(children: [
              Expanded(
                  flex: 4,
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5),
                          ),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage("$imgUrl"))))),
              Expanded(
                flex: 6,
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 31,
                              child: Text("$desc",
                                  style: GoogleFonts.poppins(
                                      fontSize: 8, color: Colors.grey[700]))),
                          SizedBox(height: 1),
                          Container(
                              child: Text("₹ $val INR",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ))),
                          SizedBox(height: 3),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                LinearPercentIndicator(
                                  width: 70.0,
                                  lineHeight: 7.0,
                                  percent: (sold / total),
                                  progressColor: Colors.green[800],
                                ),
                                Text("$sold Sold",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 8))
                              ]),
                          SizedBox(height: 3),
                          Text("On Stock $total",
                              style: GoogleFonts.poppins(
                                color: Colors.blue[800],
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                              ))
                        ])),
              )
            ])));
  }

  Widget bestPicks() {
    double width = MediaQuery.of(context).size.width;
    var homeModel = Provider.of<HomeModel>(context);
    return Container(
        height: 250,
        width: width,
        color: Colors.green[100],
        child: Stack(children: [
          Container(
              height: 180,
              width: 185,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(180)),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topCenter,
                    colors: gradient,
                  ))),
          Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 15),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Best Picks For you",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold)),
                  ])),
          Container(
              height: 180,
              width: width,
              margin: EdgeInsets.only(
                top: 60,
                left: 5,
              ),
              child: ListView(scrollDirection: Axis.horizontal, children: [
                for (var bestPick in homeModel.bestPicksData)
                  bestPickWidget(
                    imgUrl: "${bestPick["imageUrl"]}",
                    catId: bestPick["cat_id"],
                    serviceName: bestPick["name"],
                    description:
                        "${bestPick["service_name"]} : ${bestPick["service_description"].length > 0 ? bestPick["service_description"][0] : ""}",
                    price:
                        "${bestPick["charges"] + bestPick["partner_cost"]}  ${bestPick["discount"] > 0 ? "-" + bestPick["discount"].toString() + "% Discount" : ""}",
                    rating: bestPick["ratings"].toDouble(),
                  ),
              ]))
        ]));
  }

  Widget bestPickWidget(
      {@required String imgUrl,
      @required String description,
      @required String price,
      @required String catId,
      @required String serviceName,
      @required double rating}) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ServiceListing(
                      categoryID: catId,
                      catName: serviceName,
                      scrollToSubCatId: int.parse(catId),
                    )),
          );
        },
        child: Container(
            height: 130,
            width: 140,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(children: [
              Container(
                  height: 90,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10)),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage("$imgUrl")),
                  )),
              Container(
                  height: 90,
                  width: 140,
                  padding:
                      EdgeInsets.only(top: 5, left: 7, right: 7, bottom: 5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: 30,
                            child: Text("$description",
                                style: GoogleFonts.poppins(fontSize: 8))),
                        SizedBox(height: 5),
                        Text("Rs. $price",
                            style: GoogleFonts.poppins(
                              color: Colors.green[800],
                              fontSize: 10,
                            )),
                        SizedBox(height: 5),
                        SmoothStarRating(
                            allowHalfRating: false,
                            onRated: (v) {},
                            starCount: 5,
                            rating: rating,
                            size: 15.0,
                            isReadOnly: true,
                            color: primaryColor,
                            borderColor: primaryColor,
                            spacing: 0.0)
                      ]))
            ])));
  }

  Widget category() {
    var homeModel = Provider.of<HomeModel>(context);
    return Container(
        padding: EdgeInsets.only(left: 10, top: 10, right: 0, bottom: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Popular Categories",
                            style: GoogleFonts.poppins(
                              color: Colors.grey[800],
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            )),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "/allCategories");
                            },
                            child: Text("See All",
                                style: GoogleFonts.poppins(
                                  color: Colors.green[800],
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                )))
                      ])),
              SizedBox(height: 15),
              Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    for (var item in homeModel.categoryData)
                      categoryIndividual(categoryData: item)
                  ]))
            ]));
  }

  Widget categoryIndividual({@required Map<String, dynamic> categoryData}) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryDescription(categoryData: categoryData)),
          );
        },
        child: Container(
            height: 90,
            width: 100,
            child: Stack(children: [
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Container(
                          height: 80,
                          width: 70,
                          padding: EdgeInsets.all(8),
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text("${categoryData["catName"]}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 8,
                                      color: Colors.black)))))),
              Hero(
                  tag: "${categoryData["imgUrl"]}",
                  child: Container(
                      height: 50,
                      width: 60,
                      margin: EdgeInsets.only(left: 25),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 2,
                            )
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage("${categoryData["imgUrl"]}"),
                          ))))
            ])));
  }

  Widget promo() {
    var homeModel = Provider.of<HomeModel>(context);

    return Container(
        padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
        height: 120,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Promos specially for you",
                  style: GoogleFonts.poppins(
                    color: Colors.grey[800],
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  )),
              SizedBox(height: 10),
              Container(
                  height: 70,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/promoList");
                          },
                          child: Container(
                              height: 70,
                              width: 70,
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.only(top: 30, left: 30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                      begin: Alignment.center,
                                      end: Alignment.bottomRight,
                                      colors: gradient)),
                              child: Text("See All Promo",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 8)))),
                      for (var item in homeModel.promoData)
                        promoBox(
                          promoId: item["promo_id"],
                          imgurl: "${item["imgUrl"]}",
                          heading: "${item["promo_name"]}",
                          bigText: item["isPercentDiscount"]
                              ? "${item["percentageDiscount"]} %"
                              : "₹ ${item["max_discount_rupees"]}",
                          smallText: "off",
                          buttonName: "Apply Now",
                        )
                    ],
                  ))
            ]));
  }

  Widget promoBox(
      {@required String imgurl,
      @required String heading,
      @required String bigText,
      @required String smallText,
      @required int promoId,
      @required buttonName}) {
    return InkWell(
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
            height: 70,
            width: 150,
            margin: EdgeInsets.only(right: 10),
            child: Row(children: [
              Container(
                  height: 70,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage("$imgurl")))),
              Container(
                  height: 70,
                  width: 100,
                  padding:
                      EdgeInsets.only(left: 10, right: 5, bottom: 5, top: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomRight,
                        colors: gradient,
                      )),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: Colors.white)),
                            ),
                            child: Text("$heading",
                                style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white))),
                        SizedBox(height: 2),
                        StyledText(
                          text: '<big>$bigText</big> <small>$smallText</small>',
                          styles: {
                            'big': GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            'small': GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.normal)
                          },
                        ),
                        SizedBox(height: 4),
                        Container(
                            height: 12,
                            width: 40,
                            padding: EdgeInsets.only(left: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Center(
                                child: Text("$buttonName",
                                    style: GoogleFonts.poppins(
                                      fontSize: 5,
                                    ))))
                      ]))
            ])));
  }

  Widget topAppBar() {
    var homeModel = Provider.of<HomeModel>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
        height: 145,
        width: width,
        child: Stack(children: [
          Container(
            height: 145,
            width: width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [primaryColor, Colors.green[400]],
            )),
          ),
          Container(
              width: width,
              height: 170,
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20, left: 10),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hello ,",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  )),
                              Text(
                                  "${homeModel.userData == null ? "Loading..." : homeModel.userData["fname"] + " " + homeModel.userData["lname"]}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ))
                            ])),
                    Container(
                        height: 45,
                        margin: EdgeInsets.only(left: 5, top: 15),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                      onTap: _openDrawer,
                                      child: Icon(Icons.menu,
                                          color: Colors.green[800]))),
                              Expanded(
                                  flex: 8,
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, "/search");
                                      },
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              top: 5,
                                              left: 5,
                                              right: 5,
                                              bottom: 5),
                                          child: Text("Start Typing here",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.grey[600],
                                                  fontSize: 10))))),
                              Expanded(
                                  flex: 1,
                                  child: Icon(Icons.search,
                                      color: Colors.green[800]))
                            ])),
                  ])),
        ]));
  }

  Widget appBarIcon({@required String imgSrc, @required String name}) {
    return Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Image(height: 40, width: 40, image: NetworkImage("$imgSrc")),
          Text("$name",
              style: GoogleFonts.poppins(color: Colors.grey, fontSize: 8)),
        ]));
  }
}
