import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nivishka_android/util/index.dart';

class EnterPhone extends StatefulWidget {
  @override
  State<EnterPhone> createState() => _EnterPhone();
}

class _EnterPhone extends State<EnterPhone> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            body: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: [primaryColor, Colors.green[800]],
                )),
                child: Stack(children: [
                  Container(
                      padding: EdgeInsets.only(
                        top: 50,
                        bottom: 10,
                      ),
                      child: Align(
                          alignment: Alignment.topCenter,
                          child: Column(children: [
                            CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 45,
                                    child: Image(
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.contain,
                                        image:
                                            AssetImage("images/logo2.png")))),
                          ]))),
                  Container(
                      margin: EdgeInsets.only(top: 200),
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          top: 30, left: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(45))),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: Text("Login",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                    ))),
                            SizedBox(height: 30),
                            Text("Phone",
                                style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10),
                            customTextField(
                                placeholder: "Enter Phone", maxLength: 10),
                            SizedBox(height: 20),
                            gradientButton(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.9,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: gradient,
                              ),
                              shadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.0, 1.0), //(x,y)
                                  blurRadius: 6.0,
                                )
                              ],
                              border:
                                  Border.all(color: Colors.white30, width: 1.0),
                              text: "LOGIN",
                              fontSize: 14,
                              fontColor: Colors.black,
                              fontWeight: FontWeight.bold,
                              ontap: () =>
                                  {Navigator.pushNamed(context, "/otp_screen")},
                            ),
                            SizedBox(height: 30),
                            Center(
                                child: InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, "/signup");
                                    },
                                    child: Text("Create Account",
                                        style: GoogleFonts.poppins(
                                          color: Colors.black45,
                                          fontSize: 12,
                                        ))))
                          ]))
                ]))));
  }

  Widget customTextField({@required String placeholder, int maxLength}) {
    return TextField(
      maxLength: maxLength,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(5),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300]),
          ),
          hintStyle: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[400]),
          hintText: '$placeholder'),
    );
  }
}
