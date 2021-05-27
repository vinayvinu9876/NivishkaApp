import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:provider/provider.dart';
import 'package:nivishka_android/RateService/RatingModel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateService extends StatefulWidget {
  final int orderId;
  RateService({@required this.orderId});
  @override
  State<RateService> createState() => _RateService();
}

class _RateService extends State<RateService> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    RatingModel model = Provider.of<RatingModel>(context);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green[800],
            title: Text("Rating",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 18)),
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ))),
        body: Container(
            height: height,
            width: width,
            padding: EdgeInsets.all(15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 80),
                  Text("Please Rate our service",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  RatingBar.builder(
                      initialRating: 3,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return Icon(
                              Icons.sentiment_very_dissatisfied,
                              color: Colors.red,
                            );
                          case 1:
                            return Icon(
                              Icons.sentiment_dissatisfied,
                              color: Colors.redAccent,
                            );
                          case 2:
                            return Icon(
                              Icons.sentiment_neutral,
                              color: Colors.amber,
                            );
                          case 3:
                            return Icon(
                              Icons.sentiment_satisfied,
                              color: Colors.lightGreen,
                            );
                          case 4:
                            return Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.green,
                            );
                        }
                      },
                      onRatingUpdate: (double rating) {
                        print(rating);
                        model.setRating(rating);
                      }),
                  SizedBox(height: 20),
                  Builder(builder: (context) {
                    String val;
                    Color color;
                    switch (model.rating.toInt()) {
                      case 1:
                        val = "Very Bad";
                        color = Colors.red;
                        break;
                      case 2:
                        val = "Bad";
                        color = Colors.redAccent;
                        break;
                      case 3:
                        val = "Not that great";
                        color = Colors.amber;
                        break;
                      case 4:
                        val = "Great";
                        color = Colors.lightGreen;
                        break;
                      case 5:
                        val = "Awesome";
                        color = Colors.green;
                        break;
                      default:
                        print("Value received is ${model.rating}");
                        break;
                    }

                    return Visibility(
                        visible: (val != null),
                        child: Text("$val",
                            style: GoogleFonts.poppins(
                                color: color,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)));
                  }),
                  SizedBox(height: 40),
                  Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05, right: width * 0.05),
                      child: ((!model.isLoading)
                          ? InkWell(
                              onTap: () {
                                model.giveRating(widget.orderId);
                              },
                              child: Container(
                                  height: 40,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: Colors.green[800],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                      child: Text("SUBMIT",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 12)))))
                          : Container(
                              height: 50,
                              width: width,
                              child:
                                  Center(child: CircularProgressIndicator())))),
                  SizedBox(height: 40),
                  Visibility(
                      visible: (model.errorMessage != null),
                      child: Text("${model.errorMessage}",
                          style: GoogleFonts.poppins(
                              color: Colors.red, fontSize: 12))),
                  SizedBox(height: 20),
                  Visibility(
                      visible: (model.successMessage != null),
                      child: Text("${model.successMessage}",
                          style: GoogleFonts.poppins(
                              color: Colors.green[600], fontSize: 12))),
                ])));
  }
}
