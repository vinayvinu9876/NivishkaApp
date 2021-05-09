import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:nivishka_android/Home/CustomDrawer.dart';
import 'package:provider/provider.dart';
import 'package:nivishka_android/CategoryDescription/index.dart';

import 'package:nivishka_android/ServiceListing/index.dart';
import 'SearchModel.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _Search();
}

class _Search extends State<Search> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState.openDrawer();
  }

  @override
  void initState() {
    super.initState();
    var searchmodel = Provider.of<SearchModel>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => searchmodel.getCategroyData());
  }

  @override
  Widget build(BuildContext context) {
    var searchmodel = Provider.of<SearchModel>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            key: _scaffoldKey,
            drawer: CustomDrawer(),
            body: Container(
                height: height,
                width: width,
                padding: EdgeInsets.all(15),
                child: ListView(children: [
                  SizedBox(height: 30),
                  Text("Search",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      )),
                  SizedBox(height: 15),
                  Container(
                      height: 40,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: _openDrawer,
                                child: Icon(Icons.menu, color: Colors.black45)),
                            SizedBox(width: 15),
                            Expanded(
                                flex: 7,
                                child: TextField(
                                    style: GoogleFonts.poppins(
                                        fontSize: 10, color: Colors.black),
                                    onChanged: (txt) {
                                      searchmodel.searchServices(txt);
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 5,
                                            left: 10,
                                            right: 5,
                                            bottom: 5),
                                        hintText: "Type here...",
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 10,
                                          color: Colors.grey[400],
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.black,
                                        ))))),
                            Expanded(
                              flex: 1,
                              child: Icon(Icons.search, color: Colors.black26),
                            )
                          ])),
                  SizedBox(height: 15),
                  Visibility(
                      visible: searchmodel.categoryData.length > 0,
                      child: Text("All Categories",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ))),
                  SizedBox(height: 15),
                  Wrap(
                      spacing: 25.0,
                      runSpacing: 15.0,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        for (var cat in searchmodel.categoryData)
                          categoryDesc(
                              imgUrl: cat["imgUrl"],
                              name: "${cat["catName"]}",
                              categoryData: cat),
                      ]),
                  SizedBox(height: 25),
                  Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        for (var searchData in searchmodel.searchData)
                          searchDesc(
                              imgUrl: searchData["imageUrl"],
                              name: searchData["service_name"],
                              catId: searchData["cat_id"],
                              cost:
                                  "Get flat discount of ${searchData["discount"]} %")
                      ])),
                  Visibility(
                      visible: searchmodel.isLoading,
                      child: Container(
                          child:
                              Column(children: [CircularProgressIndicator()])))
                ]))));
  }

  Widget searchDesc(
      {@required String imgUrl,
      @required String name,
      @required String cost,
      @required String catId}) {
    double width = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ServiceListing(
                      categoryID: catId,
                      catName: name,
                      scrollToSubCatId: int.parse(catId),
                    )),
          );
        },
        child: Container(
            width: width,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(width: 1.0, color: Colors.grey[200]),
                    bottom: BorderSide(width: 1.0, color: Colors.grey[200]))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 55,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage("$imgUrl"),
                          ))),
                  SizedBox(width: 10),
                  Expanded(
                      child: Container(
                          height: 50,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("$name",
                                    style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                                Text("Cost $cost",
                                    style: GoogleFonts.poppins(
                                      fontSize: 8,
                                      color: Colors.black38,
                                    ))
                              ])))
                ])));
  }

  Widget categoryDesc(
      {@required String imgUrl,
      @required String name,
      @required Map<String, dynamic> categoryData}) {
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
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage("$imgUrl")))),
              SizedBox(height: 10),
              Text("$name",
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w500))
            ])));
  }
}
