import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'PromoDescriptionModel.dart';
import 'package:nivishka_android/util/index.dart';

class PromoDescription extends StatefulWidget {
  final int promoId;
  PromoDescription({@required this.promoId});
  @override
  State<PromoDescription> createState() => _PromoDescription();
}

class _PromoDescription extends State<PromoDescription> {
  @override
  void initState() {
    super.initState();
    var promoDescModel =
        Provider.of<PromoDescriptionModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => promoDescModel.getPromoData(widget.promoId));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var promoDescModel = Provider.of<PromoDescriptionModel>(context);
    String imgUrl =
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFr4GrrksBQXTmfSHkFCsEpUJGQsizGoUGWDEcQ7F12rH6kveBHr6g3L0NTU8W_HQiiFY&usqp=CAU",
        name = "",
        code = "";
    List<dynamic> desc = [];

    if (promoDescModel.promoData != null) {
      imgUrl = promoDescModel.promoData["imgUrl"];
      name = promoDescModel.promoData["promo_name"];
      code = promoDescModel.promoData["promo_code"];
      desc = promoDescModel.promoData["terms_and_conditions"];
    }

    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: Colors.black)),
              title: Text("Promo Details",
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
            body: Container(
                height: height,
                width: width,
                child: Column(children: [
                  Visibility(
                    visible: promoDescModel.isLoading,
                    child: Expanded(
                        child: Container(
                            child: Center(child: CircularProgressIndicator()))),
                  ),
                  Visibility(
                      visible: (!promoDescModel.isLoading &&
                          (promoDescModel.promoData != null)),
                      child: Expanded(
                          child: ListView(children: [
                        Container(
                          height: 200,
                          width: width,
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("$imgUrl"))),
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                top: 15, left: 15, right: 10, bottom: 5),
                            child: Text("$name",
                                style: GoogleFonts.poppins(fontSize: 12))),
                        Container(
                            padding: EdgeInsets.only(
                                left: 15, right: 10, top: 5, bottom: 5),
                            child: Text("#$code",
                                style: GoogleFonts.poppins(
                                    color: Colors.green[600],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14))),
                        Container(
                            padding: EdgeInsets.only(
                                left: 15, right: 10, top: 15, bottom: 5),
                            child: Text("Offer Details",
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600))),
                        Container(
                            padding: EdgeInsets.only(
                                left: 15, right: 10, top: 5, bottom: 5),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (String descString in desc)
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      child: Bullet("$descString",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 10)),
                                    )
                                ])),
                        SizedBox(height: 20),
                        Container(
                            padding: EdgeInsets.only(
                                left: 15, right: 10, top: 5, bottom: 5),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/allCategories");
                                      },
                                      child: Card(
                                          elevation: 2,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                              ),
                                              padding: EdgeInsets.all(10),
                                              child: Text("Claim Now",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10)))))
                                ]))
                      ])))
                ]))));
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
          '• ${data}',
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
