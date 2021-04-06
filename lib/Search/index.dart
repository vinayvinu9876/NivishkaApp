import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:nivishka_android/Home/CustomDrawer.dart';

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
  Widget build(BuildContext context) {
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
                  Text("All Categories",
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(height: 15),
                  Wrap(
                      spacing: 25.0,
                      runSpacing: 15.0,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        categoryDesc(
                          imgUrl:
                              "https://images-na.ssl-images-amazon.com/images/I/41NiOrxNI8L.jpg",
                          name: "Saloon",
                        ),
                        categoryDesc(
                          imgUrl:
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvh8KQtTexpbt3DYLqF8XmOiED-hcqmvdLog&usqp=CAU",
                          name: "Plumbers",
                        ),
                        categoryDesc(
                          imgUrl:
                              "https://hiring-assets.careerbuilder.com/media/attachments/careerbuilder-original-3580.jpg?1511294086",
                          name: "Electrician",
                        ),
                        categoryDesc(
                            imgUrl:
                                "https://cdn.123test.com/content/beroepen/loodgieter.jpg",
                            name: "Plumber"),
                        categoryDesc(
                            imgUrl:
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4MRYKUdXecNurqmNdxksDyEiZtV4ySn1stw&usqp=CAU",
                            name: "Repairs"),
                        categoryDesc(
                            imgUrl:
                                "https://content3.jdmagicbox.com/comp/sahibabad/l3/011pxx11.xx11.191006142514.x2l3/catalogue/all-time-massage-parlour-sahibabad-0xs75zq7ih.jpg?clr=4d331a",
                            name: "Massage"),
                        categoryDesc(
                            imgUrl:
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBS-ujyWqYDfzl_okH3J-rqO3PMVpV248BFg&usqp=CAU",
                            name: "Mens"),
                        categoryDesc(
                            imgUrl:
                                "https://hiring-assets.careerbuilder.com/media/attachments/careerbuilder-original-3580.jpg?1511294086",
                            name: "Electrician"),
                      ]),
                  SizedBox(height: 25),
                  Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Container(
                            width: width,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        width: 1.0, color: Colors.grey[200]),
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.grey[200]))),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 55,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBS-ujyWqYDfzl_okH3J-rqO3PMVpV248BFg&usqp=CAU"),
                                          ))),
                                  SizedBox(width: 10),
                                  Expanded(
                                      child: Container(
                                          height: 50,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text("Men's Saloon",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                Text(
                                                    "All saloon services with the best services at affordable price",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 8,
                                                      color: Colors.black38,
                                                    ))
                                              ])))
                                ]))
                      ]))
                ]))));
  }

  Widget categoryDesc({@required String imgUrl, @required String name}) {
    return Container(
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
        ]));
  }
}
