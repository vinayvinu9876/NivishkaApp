import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class AllCategories extends StatefulWidget {
  @override
  State<AllCategories> createState() => _AllCategories();
}

class _AllCategories extends State<AllCategories> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            bottomNavigationBar: CustomBottomNavBar(),
            body: Container(
                height: height,
                width: width,
                child: ListView(children: [
                  topAppBar(),
                  Container(
                      child: Column(children: [
                    categoryIndividual(
                        name: "Cleaning And Disinfection",
                        categories: [
                          CleaningWidget(
                              imgUrl:
                                  "https://res.cloudinary.com/urbanclap/image/upload/t_medium_res_template,q_30/categories/category_v2/category_2e4ed020.png",
                              name: "PEST CONTROL"),
                          CleaningWidget(
                              imgUrl:
                                  "https://res.cloudinary.com/urbanclap/image/upload/t_low_res_portfolio_medium,q_auto:low,f_auto/categories/category_v2/category_612b5ea0.jpeg",
                              name: "HOME AND CAR"),
                          CleaningWidget(
                              imgUrl:
                                  "https://res.cloudinary.com/urbanclap/image/upload/t_low_res_portfolio_medium,q_auto:low,f_auto/categories/category_v2/category_6567f6e0.jpeg",
                              name: "SMALL OFFICES AND SHOPS"),
                          CleaningWidget(
                              imgUrl:
                                  "https://res.cloudinary.com/urbanclap/image/upload/t_low_res_portfolio_medium,q_auto:low,f_auto/categories/category_v2/category_64d97280.jpeg",
                              name: "LARGE OFFICES"),
                        ]),
                    categoryIndividual(name: "Salon For Women", categories: [
                      CleaningWidget(
                          imgUrl:
                              "https://res.cloudinary.com/urbanclap/image/upload/fl_progressive,t_medium_res_template/categories/category_v2/category_24ad7c60.png",
                          name: "Salon at Home"),
                      CleaningWidget(
                          imgUrl:
                              "https://images.squarespace-cdn.com/content/v1/5366a336e4b0d727dcd0c9d2/1571850319104-ZPXJVGAEVT3YKJQW4RKB/ke17ZwdGBToddI8pDm48kKaCGyJkFXRmxRE7GyBPsxIUqsxRUqqbr1mOJYKfIPR7LoDQ9mXPOjoJoqy81S2I8N_N4V1vUb5AoIIIbLZhVYxCRW4BPu10St3TBAUQYVKcdMQSebvaVoIiVoMvTKRRFVd-hEHjms_FAXw-VPCphwiIay8beCdfImv-2EE0K3To/How-To-Become-a-Successful-Makeup-Artist-nina-mua.jpg",
                          name: "MakeUp"),
                      CleaningWidget(
                          imgUrl:
                              "https://image.wedmegood.com/resized/800X/uploads/member/459313/1577953034_bridal_makeup_artist_in_kolkata_near_me.jpg",
                          name: "Bridal Makeup"),
                    ]),
                    categoryIndividual(name: "Electronics", categories: [
                      CleaningWidget(
                          imgUrl:
                              "https://content.jdmagicbox.com/comp/bangalore/c6/080pxx80.xx80.200618151221.f2c6/catalogue/the-power-bangalore-qwftty2mi0.jpg?clr=",
                          name: "Electricians"),
                      CleaningWidget(
                          imgUrl:
                              "https://www.itrepairsonline.com/wp-content/uploads/2020/01/services-upgrade.jpg",
                          name: "Computer Repairs"),
                      CleaningWidget(
                          imgUrl:
                              "https://sulcdn.azureedge.net/content/images/listings/listseo/split-ac-service.jpg",
                          name: "AC Repairs"),
                    ]),
                    categoryIndividual(name: "Plumbers", categories: [
                      CleaningWidget(
                          imgUrl:
                              "https://5.imimg.com/data5/PB/MW/MY-7343282/tap-repair-500x500.jpg",
                          name: "Wash Basin Repair"),
                      CleaningWidget(
                          imgUrl:
                              "https://www.thespruce.com/thmb/_ghMjrCifag2sWGXdF8gf-xUzzw=/450x0/filters:no_upscale():max_bytes(150000):strip_icc()/close-up-of-faucet-and-bathtub-in-modern-bathroom-533766033-59b6b6469abed50011672dcf.jpg",
                          name: "Bath Tub Repair"),
                      CleaningWidget(
                          imgUrl:
                              "https://www.orangecountyplumbinghvac.com/wp-content/uploads/2016/12/Shower-Installation.jpg",
                          name: "Shower Installation"),
                    ]),
                  ]))
                ]))));
  }

  Widget categoryIndividual(
      {@required String name, @required List<CleaningWidget> categories}) {
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
                color: blue,
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
                                color: Colors.white,
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

class CleaningWidget extends StatelessWidget {
  String imgUrl, name;
  CleaningWidget({@required this.imgUrl, @required this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    ]))));
  }
}
