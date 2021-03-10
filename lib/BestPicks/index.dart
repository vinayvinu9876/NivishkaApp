import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class BestPicks extends StatefulWidget {
  @override
  State<BestPicks> createState() => _BestPicks();
}

class _BestPicks extends State<BestPicks> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            title: Text("Best Picks For you",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                ))),
        body: Container(
            height: height,
            width: width,
            padding: EdgeInsets.all(15),
            child: Wrap(
                runSpacing: 8.0,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  bestPickWidget(
                    imgUrl:
                        "https://de927adv5b23k.cloudfront.net/wp-content/uploads/2019/03/27192455/salon-hygiene-checklist.png",
                    description:
                        "Massage Services at your home with full features",
                    price: "10,000",
                    rating: 4,
                  ),
                  bestPickWidget(
                    imgUrl:
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMCvgKB2KLCgfjE1f4dtb9gIKrZYenPwfLZQ&usqp=CAU",
                    description:
                        "Plumbing Services at your home before you start facing problems",
                    price: "5,000",
                    rating: 5,
                  ),
                  bestPickWidget(
                    imgUrl:
                        "https://res.cloudinary.com/urbanclap/image/upload/q_auto,f_auto,fl_progressive:steep,w_617/t_high_res_template,q_auto:low,f_auto/categories/category_v2/category_ba329560.png",
                    description: "Lazy to clean ? Call me right now",
                    price: "2,000",
                    rating: 5,
                  ),
                ])));
  }

  Widget bestPickWidget(
      {@required String imgUrl,
      @required String description,
      @required String price,
      @required double rating}) {
    return InkWell(
        onTap: () {},
        child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Container(
                height: 180,
                width: 140,
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
                                  color: lightblue,
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
                                color: blue,
                                borderColor: blue,
                                spacing: 0.0)
                          ]))
                ]))));
  }
}
