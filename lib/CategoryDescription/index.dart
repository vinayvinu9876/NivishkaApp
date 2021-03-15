import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:timelines/timelines.dart';

class CategoryDescription extends StatefulWidget {
  @override
  State<CategoryDescription> createState() => _CategoryDescription();
}

class _CategoryDescription extends State<CategoryDescription> {
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
                  Container(
                      width: width,
                      height: height * 0.3,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 25.0,
                            ),
                          ],
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "https://profiles.sulekha.com/mstore/2063368/albums/default/thumbnailfull/plumber.jpg")))),
                  Container(
                      width: width,
                      height: 55,
                      decoration: BoxDecoration(
                        color: blue,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 25.0,
                          ),
                        ],
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Plumbers and Rapairs",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                            Text("Get upto 15% offer | Limited Offer",
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: 8,
                                ))
                          ])),
                  Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 15),
                      child: Text("Please Select",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold))),
                  Container(
                      width: width,
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 10),
                      child: Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          runAlignment: WrapAlignment.start,
                          spacing: 25.0,
                          runSpacing: 10.0,
                          children: [
                            categorySelect(
                                image:
                                    "https://images-na.ssl-images-amazon.com/images/I/41NiOrxNI8L.jpg",
                                name: "Basin and Sink"),
                            categorySelect(
                                image:
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQvh8KQtTexpbt3DYLqF8XmOiED-hcqmvdLog&usqp=CAU",
                                name: "Bath Fitting"),
                            categorySelect(
                                image:
                                    "https://web.cdn.aspect.co.uk/wp-content/uploads/2018/08/05201431/Drainage_SP_0081_Blocked_Sink-1024x683.jpg",
                                name: "Blockage"),
                            categorySelect(
                                image:
                                    "https://images-na.ssl-images-amazon.com/images/I/415bpe12NML._SY355_.jpg",
                                name: "Tap and Mixer"),
                            categorySelect(
                                image:
                                    "https://secure.img1-fg.wfcdn.com/im/19969045/compr-r85/1167/116735217/128-gpf-elongated-one-piece-toilet-seat-included.jpg",
                                name: "Toilet"),
                            categorySelect(
                                image:
                                    "https://5.imimg.com/data5/GB/LI/MY-25595663/plastic-water-tank-500x500.jpg",
                                name: "Water Tank"),
                          ])),
                  Container(
                    height: 10,
                    width: width,
                    color: Colors.grey[300],
                  ),
                  Container(
                      width: width,
                      padding: EdgeInsets.all(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("How it works ?",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            howItWorks(
                                iconName: Icons.assignment,
                                title: "Choose the type of Service",
                                subtitle: "Select the service required"),
                            timelineLine(),
                            howItWorks(
                                iconName: Icons.alarm,
                                title: "Choose your time slot",
                                subtitle: "We service from 9am to 9pm"),
                            timelineLine(),
                            howItWorks(
                                iconName: Icons.how_to_reg,
                                title: "Hassle free service",
                                subtitle:
                                    "Our professionals will get in touch with you one hour before the service"),
                          ])),
                  Container(
                    height: 3,
                    width: width,
                    color: Colors.grey[300],
                  ),
                  Container(
                      width: width,
                      padding: EdgeInsets.all(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Plumbers in Bangalore",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                            Text(
                                "Get plumbers in Bangalore near you within 90 minute with 300..",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey, fontSize: 10))
                          ])),
                  Container(
                    height: 15,
                    width: width,
                    color: Colors.grey[300],
                  ),
                  Container(
                      width: width,
                      padding: EdgeInsets.all(15),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Plumbers",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                )),
                            Text("394 plumbers in bangalore",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey, fontSize: 10)),
                            SizedBox(height: 25),
                            Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex: 2,
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                  "https://res.cloudinary.com/urbanclap/image/upload/t_medium_res_profile_thumb,q_auto:low,f_auto/images/5cf8c2d0c67ebf2600a6d36e/1560249801512-45bf46effe2cbcba1757c194c6231af0.jpeg"),
                                            )),
                                        Expanded(
                                            flex: 8,
                                            child: Container(
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text("Purushotham R",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                      Text(
                                                          "15/33 , 13th main Road,Hanumagiri, Nisarga Layout,Chikkalsandra,Bengaluru,Karnataka",
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                          .grey[
                                                                      600])),
                                                      SizedBox(
                                                        height: 6,
                                                      ),
                                                      Container(
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                            Icon(
                                                              Icons.star,
                                                              size: 12,
                                                              color: Colors
                                                                  .green[800],
                                                            ),
                                                            SizedBox(width: 3),
                                                            Text("4.5",
                                                                style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                            .green[
                                                                        800],
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        10)),
                                                            SizedBox(width: 4),
                                                            Text(
                                                                "(488 ratings)",
                                                                style: GoogleFonts.poppins(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                            .grey[
                                                                        800]))
                                                          ]))
                                                    ])))
                                      ]),
                                  Container(
                                      width: width,
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.yellow,
                                                child: Center(
                                                    child: Text("B",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize:
                                                                    14)))),
                                            SizedBox(width: 10),
                                            Expanded(
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                  Text("Benson",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Icon(
                                                          Icons.star,
                                                          size: 10,
                                                          color:
                                                              Colors.green[800],
                                                        ),
                                                        SizedBox(width: 3),
                                                        Text("4.5",
                                                            style: GoogleFonts.poppins(
                                                                color: Colors
                                                                    .green[800],
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 8)),
                                                      ]),
                                                  SizedBox(height: 5),
                                                  Text(
                                                      "15/33 , 13th main Road,Hanumagiri, Nisarga Layout,Chikkalsandra,Bengaluru,Karnataka",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 8,
                                                              color: Colors
                                                                  .grey[600])),
                                                ]))
                                          ]))
                                ])),
                          ])),
                  SizedBox(height: 20),
                ]))));
  }

  Widget timelineLine() {
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Expanded(
              flex: 2,
              child: Container(
                  child: Column(children: [
                Container(
                  height: 35,
                  width: 3,
                  color: Colors.black,
                )
              ]))),
          Expanded(flex: 8, child: SizedBox())
        ]));
  }

  Widget howItWorks(
      {@required IconData iconName,
      @required String title,
      @required String subtitle}) {
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Expanded(
              flex: 2,
              child: RawMaterialButton(
                onPressed: () {},
                elevation: 1.0,
                fillColor: Colors.grey[900],
                child: Icon(
                  iconName,
                  size: 20.0,
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(10.0),
                shape: CircleBorder(),
              )),
          Expanded(
              flex: 8,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text("$title",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    Text("$subtitle",
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 10))
                  ]))
        ]));
  }

  Widget categorySelect({@required String image, @required String name}) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, "/serviceListing");
        },
        child: Container(
            height: 100,
            width: 80,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                      radius: 25, backgroundImage: NetworkImage("$image")),
                  SizedBox(height: 5),
                  Text("$name",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 8,
                          fontWeight: FontWeight.w600))
                ])));
  }
}
