import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class About extends StatefulWidget {
  @override
  State<About> createState() => _About();
}

class _About extends State<About> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                  onTap: () => Navigator.pushNamedAndRemoveUntil(
                      context, "/home", (Route<dynamic> route) => false),
                  child: Icon(Icons.arrow_back, color: Colors.white)),
              backgroundColor: Colors.green[500],
              title: Text("About Nivishka",
                  style:
                      GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
            ),
            body: Container(
                height: height,
                width: width,
                color: Colors.white24,
                padding: EdgeInsets.all(15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Image(
                              height: 120,
                              width: 120,
                              image: AssetImage("images/logo2.png"))),
                      SizedBox(height: 15),
                      Container(
                          child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 10, color: Colors.grey[600]))),
                      SizedBox(height: 35),
                      Container(
                          child: Text(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                  fontSize: 10, color: Colors.grey[600]))),
                      SizedBox(height: 25),
                      InkWell(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(context, "/home",
                                (Route<dynamic> route) => false);
                          },
                          child: Text("Back",
                              style: GoogleFonts.poppins(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold)))
                    ]))));
  }
}
