import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:styled_text/styled_text.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            body: Container(
                height: height,
                width: width,
                child: ListView(children: [
                  topAppBar(),
                  SizedBox(height: 10),
                  promo(),
                  category(),
                  SizedBox(height: 10),
                  bestPicks(),
                ]))));
  }

  Widget bestPicks() {
    double width = MediaQuery.of(context).size.width;
    return Container(
        height: 250,
        width: width,
        color: Color(0xFFccf2ff),
        child: Stack(children: [
          Container(
              height: 180,
              width: width * 0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(width * 0.6)),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.topCenter,
                    colors: [blue, Colors.blue],
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
                    Text("See All",
                        style: GoogleFonts.poppins(
                          color: Colors.blue[800],
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ))
                  ])),
          Container(
              height: 180,
              width: width,
              margin: EdgeInsets.only(
                top: 60,
                left: 5,
              ),
              child: ListView(scrollDirection: Axis.horizontal, children: [
                Container(
                    height: 130,
                    width: 140,
                    margin: EdgeInsets.only(left: 15, right: 15),
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
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://de927adv5b23k.cloudfront.net/wp-content/uploads/2019/03/27192455/salon-hygiene-checklist.png")),
                          )),
                      Container(
                          height: 90,
                          width: 140,
                          padding: EdgeInsets.only(
                              top: 5, left: 7, right: 7, bottom: 5),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Massage Services at your home with full features",
                                    style: GoogleFonts.poppins(fontSize: 8)),
                                SizedBox(height: 5),
                                Text("Rs. 10,000",
                                    style: GoogleFonts.poppins(
                                      color: lightblue,
                                      fontSize: 10,
                                    )),                         ]))
                    ]))
              ]))
        ]));
  }

  Widget category() {
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
                        Text("See All",
                            style: GoogleFonts.poppins(
                              color: blue,
                              fontSize: 10,
                            ))
                      ])),
              SizedBox(height: 15),
              Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    categoryIndividual(
                        imgurl:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIYHM6EoOE4xAFozSlHYW19OcjlT8ETx_hzA&usqp=CAU",
                        name: "Womens Salon"),
                    categoryIndividual(
                        imgurl:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBS-ujyWqYDfzl_okH3J-rqO3PMVpV248BFg&usqp=CAU",
                        name: "Mens Salon"),
                    categoryIndividual(
                        imgurl:
                            "https://hiring-assets.careerbuilder.com/media/attachments/careerbuilder-original-3580.jpg?1511294086",
                        name: "Electrician"),
                    categoryIndividual(
                        imgurl:
                            "https://cdn.123test.com/content/beroepen/loodgieter.jpg",
                        name: "Plumber"),
                    categoryIndividual(
                        imgurl:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4MRYKUdXecNurqmNdxksDyEiZtV4ySn1stw&usqp=CAU",
                        name: "Repairs"),
                    categoryIndividual(
                        imgurl:
                            "https://content3.jdmagicbox.com/comp/sahibabad/l3/011pxx11.xx11.191006142514.x2l3/catalogue/all-time-massage-parlour-sahibabad-0xs75zq7ih.jpg?clr=4d331a",
                        name: "Massage"),
                    categoryIndividual(
                        imgurl:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBS-ujyWqYDfzl_okH3J-rqO3PMVpV248BFg&usqp=CAU",
                        name: "Mens"),
                    categoryIndividual(
                        imgurl:
                            "https://hiring-assets.careerbuilder.com/media/attachments/careerbuilder-original-3580.jpg?1511294086",
                        name: "Electrician"),
                    categoryIndividual(
                        imgurl:
                            "https://cdn.123test.com/content/beroepen/loodgieter.jpg",
                        name: "Plumber"),
                    categoryIndividual(
                        imgurl:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4MRYKUdXecNurqmNdxksDyEiZtV4ySn1stw&usqp=CAU",
                        name: "Repairs"),
                    categoryIndividual(
                        imgurl:
                            "https://content3.jdmagicbox.com/comp/sahibabad/l3/011pxx11.xx11.191006142514.x2l3/catalogue/all-time-massage-parlour-sahibabad-0xs75zq7ih.jpg?clr=4d331a",
                        name: "Massage"),
                  ]))
            ]));
  }

  Widget categoryIndividual({@required String imgurl, @required String name}) {
    return Container(
        margin: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage("$imgurl"),
              ),
              SizedBox(height: 0),
              Text("$name",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 8,
                  ))
            ]));
  }

  Widget promo() {
    return Container(
        padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
        height: 120,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Promo",
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
                      Container(
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
                                  fontSize: 8))),
                      promoBox(
                        imgurl:
                            "https://i0.wp.com/cdn.whatsuplife.in/kolkata/blog/2017/08/featured-8.jpg",
                        heading: "Spring Sale",
                        bigText: "50%",
                        smallText: "off",
                        buttonName: "Apply Now",
                      ),
                      promoBox(
                        imgurl:
                            "https://m.economictimes.com/thumb/msid-72103130,width-1200,height-900,resizemode-4,imgsize-626385/femina-flaunt-studio-salon-will-follow-a-hybrid-model-of-growth-to-expand-to-over-100-salons-in-five-years-.jpg",
                        heading: "Fashion Sale",
                        bigText: "30%",
                        smallText: "off",
                        buttonName: "Apply Now",
                      ),
                      promoBox(
                        imgurl:
                            "https://i0.wp.com/cdn.whatsuplife.in/kolkata/blog/2017/08/featured-8.jpg",
                        heading: "Spring Sale",
                        bigText: "50%",
                        smallText: "off",
                        buttonName: "Apply Now",
                      ),
                      promoBox(
                        imgurl:
                            "https://m.economictimes.com/thumb/msid-72103130,width-1200,height-900,resizemode-4,imgsize-626385/femina-flaunt-studio-salon-will-follow-a-hybrid-model-of-growth-to-expand-to-over-100-salons-in-five-years-.jpg",
                        heading: "Fashion Sale",
                        bigText: "30%",
                        smallText: "off",
                        buttonName: "Apply Now",
                      ),
                    ],
                  ))
            ]));
  }

  Widget promoBox(
      {@required String imgurl,
      @required String heading,
      @required String bigText,
      @required String smallText,
      @required buttonName}) {
    return Container(
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
              padding: EdgeInsets.only(left: 10, right: 5, bottom: 5, top: 5),
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
                              bottom:
                                  BorderSide(width: 1.0, color: Colors.white)),
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
                            color: Colors.white, fontWeight: FontWeight.bold),
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
        ]));
  }

  Widget topAppBar() {
    double width = MediaQuery.of(context).size.width;
    return Container(
        height: 180,
        width: width,
        child: Stack(children: [
          Container(
            height: 145,
            width: width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF09C6F9), Color(0xFF045DE9)],
            )),
          ),
          Container(
              width: width,
              height: 100,
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
              child: Column(children: [
                SizedBox(height: 10),
                Container(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.menu,
                            color: blue,
                          ),
                          suffixIcon: Icon(Icons.shopping_bag, color: blue),
                          fillColor: Colors.white,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          hintStyle: GoogleFonts.poppins(
                              color: Colors.grey[400], fontSize: 10),
                          hintText: 'I am looking for'),
                    ))
              ])),
          Container(
              margin: EdgeInsets.only(left: 15, top: 75),
              child: Text("Choose Style",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ))),
          Container(
              height: 70,
              margin: EdgeInsets.only(top: 105),
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15.0,
                      )
                    ],
                    color: Colors.white,
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        appBarIcon(
                            imgSrc:
                                "https://media.istockphoto.com/vectors/stand-hairdryer-color-icon-hood-hair-dryer-and-comfortable-chair-vector-id1208889195",
                            name: "Men Salon"),
                        appBarIcon(
                            imgSrc:
                                "https://static2.bigstockphoto.com/4/2/2/large2/224515747.jpg",
                            name: "Women Salon"),
                        appBarIcon(
                            imgSrc:
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSaoXyHlkYvJlM-QAxo_lrnkjnBRXi2cX63sA&usqp=CAU",
                            name: "Massage"),
                        appBarIcon(
                            imgSrc:
                                "https://cdn10.bostonmagazine.com/wp-content/uploads/2015/06/shutterstock_fresh-faced-bride.jpg",
                            name: "Bridal MakeUp")
                      ])))
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
