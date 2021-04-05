import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _Signup();
}

class _Signup extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: gradient,
                )),
                child: Column(
                  children: [
                    Container(
                        height: 70,
                        padding: EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/enterPhone");
                                  },
                                  child: Icon(Icons.arrow_back,
                                      color: Colors.black)),
                              Center(
                                  child: Text("Sign Up",
                                      style: GoogleFonts.poppins(
                                          fontSize: 18, color: Colors.black))),
                              Container()
                            ])),
                    Expanded(
                        child: Container(
                            height: MediaQuery.of(context).size.height - 70,
                            padding:
                                EdgeInsets.only(left: 30, right: 30, top: 20),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(45))),
                            child: ListView(children: [
                              field(
                                  fieldName: "First Name",
                                  placeholder: "Ex : John"),
                              SizedBox(height: 10),
                              field(
                                  fieldName: "Last Name",
                                  placeholder: "Ex: Doe",
                                  textLimit: 10),
                              SizedBox(height: 10),
                              field(
                                  fieldName: "Email",
                                  placeholder: "Ex : johndoe@gmail.com"),
                              SizedBox(height: 10),
                              field(
                                  fieldName: "Phone",
                                  placeholder: "Ex: 9108205639",
                                  textLimit: 10),
                              SizedBox(height: 25),
                              SizedBox(height: 10),
                              field(
                                  fieldName: "Refferal Code (optional)",
                                  placeholder: "Ex : ABC3432DS",
                                  textLimit: 10),
                              SizedBox(height: 25),
                              gradientButton(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.4,
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: gradient,
                                ),
                                shadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0.0, 1.0), //(x,y)
                                    blurRadius: 3.0,
                                  )
                                ],
                                border: Border.all(
                                    color: Colors.white30, width: 1.0),
                                text: "SIGN UP",
                                fontSize: 14,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.bold,
                                ontap: () => {
                                  Navigator.pushNamed(context, "/enterPhone")
                                },
                              ),
                              SizedBox(height: 10),
                              Center(
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/enterPhone");
                                      },
                                      child: Text(
                                          "Already Have Account ? Click Here",
                                          style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 12,
                                          )))),
                              SizedBox(height: 20),
                            ])))
                  ],
                ))));
  }

  Widget field(
      {@required String fieldName,
      @required String placeholder,
      int textLimit}) {
    return Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
            padding: EdgeInsets.only(top: 10, left: 15, right: 5, bottom: 0),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200],
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 3.0,
                ),
              ],
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$fieldName",
                      style: GoogleFonts.poppins(
                          fontSize: 10, fontWeight: FontWeight.bold)),
                  customTextField(
                      placeholder: "$placeholder", maxLength: textLimit),
                ])));
  }

  Widget customTextField({@required String placeholder, int maxLength}) {
    return TextField(
      maxLength: maxLength,
      style:
          GoogleFonts.poppins(fontSize: 10, height: 2.0, color: Colors.black),
      decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
          hintStyle: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[400]),
          hintText: '$placeholder'),
    );
  }
}
