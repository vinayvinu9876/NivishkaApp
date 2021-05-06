import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'AllCategoryModel.dart';
import 'package:provider/provider.dart';
import 'package:nivishka_android/ServiceListing/index.dart';

class AllCategories extends StatefulWidget {
  @override
  State<AllCategories> createState() => _AllCategories();
}

class _AllCategories extends State<AllCategories> {
  @override
  void initState() {
    super.initState();
    var allCategoryModel =
        Provider.of<AllCategoryModel>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => allCategoryModel.getAllCategoryData());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var allCategoryModel = Provider.of<AllCategoryModel>(context);
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            bottomNavigationBar: CustomBottomNavBar(selectedIndex: 0),
            body: Container(
                height: height,
                width: width,
                child: Column(children: [
                  topAppBar(),
                  Visibility(
                      visible: (allCategoryModel.errorMessage != null &&
                          (allCategoryModel.isLoading)),
                      child: Expanded(
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text("${allCategoryModel.errorMessage}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.red, fontSize: 10))
                                ],
                              )))),
                  Visibility(
                      visible: allCategoryModel.isLoading,
                      child: Expanded(
                          child: Container(
                              child: Center(
                        child: CircularProgressIndicator(),
                      )))),
                  Visibility(
                      visible: !allCategoryModel.isLoading,
                      child: Expanded(
                          child: Container(
                              child: ListView(children: [
                        Container(
                            child: Column(children: [
                          for (var key in allCategoryModel.categoryData.keys)
                            categoryIndividual(name: "$key", categories: [
                              for (var catData
                                  in allCategoryModel.categoryData[key])
                                CategoryServiceWidget(
                                    categoryName: key,
                                    catId: catData["cat_id"],
                                    imgUrl: "${catData["imageUrl"]}",
                                    name: "${catData["service_name"]}"),
                            ]),
                        ]))
                      ]))))
                ]))));
  }

  Widget categoryIndividual(
      {@required String name,
      @required List<CategoryServiceWidget> categories}) {
    double width = MediaQuery.of(context).size.width;
    return Container(
        height: 170,
        width: width,
        padding: EdgeInsets.only(left: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text("$name",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: 0.5,
                      fontSize: 12)),
              SizedBox(height: 10),
              Container(
                  height: 120,
                  width: width,
                  child: ListView(
                      scrollDirection: Axis.horizontal, children: categories))
            ]));
  }

  Widget topAppBar() {
    double width = MediaQuery.of(context).size.width;
    return Container(
        height: 160,
        width: width,
        child: Stack(children: [
          Container(
              height: 150,
              width: width,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(50, 10),
                  bottomRight: Radius.elliptical(350, 160),
                ),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 40, left: 15),
                        child: Text("Categories",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 18,
                                letterSpacing: 1,
                                fontWeight: FontWeight.w600))),
                    SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: SizedBox(
                            height: 40,
                            child: Material(
                                elevation: 5.0,
                                shadowColor: Colors.grey,
                                borderRadius: BorderRadius.circular(20.0),
                                child: TextField(
                                    style: GoogleFonts.poppins(fontSize: 10),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Search here",
                                      hintStyle: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: 10,
                                          bottom: 5,
                                          right: 5,
                                          top: 5),
                                      prefixIcon: Icon(Icons.search,
                                          color: Colors.black),
                                      border: new OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(20.0),
                                        ),
                                      ),
                                    )))))
                  ])),
        ]));
  }
}

class CategoryServiceWidget extends StatelessWidget {
  String imgUrl, name, categoryName;
  String catId;
  CategoryServiceWidget(
      {@required this.imgUrl,
      @required this.catId,
      @required this.categoryName,
      @required this.name});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ServiceListing(
                      categoryID: catId,
                      catName: categoryName,
                      scrollToSubCatId: int.parse(catId),
                    )),
          );
        },
        child: Container(
            margin: EdgeInsets.all(2),
            child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 7,
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10)),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage("$imgUrl"))))),
                          Expanded(
                              flex: 3,
                              child: Container(
                                  width: 120,
                                  padding: EdgeInsets.only(
                                      left: 2, right: 2, top: 2, bottom: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Center(
                                      child: Text("$name",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 8,
                                            color: Colors.grey,
                                          )))))
                        ])))));
  }
}
