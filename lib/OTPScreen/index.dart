import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:styled_text/styled_text.dart';

class OTPScreen extends StatefulWidget {
  @override
  State<OTPScreen> createState() => _OTPScreen();
}

class _OTPScreen extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          body: Container(
              width: width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomLeft,
                colors: gradient,
              )),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        height: 200,
                        width: width,
                        child: Center(
                            child: Text("Verification Code",
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 18)))),
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(45))),
                            child: Column(children: [
                              SizedBox(height: 20),
                              Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                      "Please Enter verification code sent to your mobile",
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ))),
                              SizedBox(height: 20),
                              OTPTextField(
                                length: 4,
                                width: MediaQuery.of(context).size.width * 0.6,
                                fieldWidth: 40,
                                style: TextStyle(fontSize: 12),
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldStyle: FieldStyle.underline,
                                onCompleted: (pin) {
                                  print("Completed: " + pin);
                                },
                              ),
                              SizedBox(height: 40),
                              gradientButton(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.7,
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
                                text: "VERIFY CODE",
                                fontSize: 12,
                                fontColor: Colors.black,
                                fontWeight: FontWeight.bold,
                                ontap: () => {
                                  Navigator.pushNamed(context, "/enterPhone")
                                },
                              ),
                              SizedBox(height: 20),
                              Center(
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "/enterPhone");
                                      },
                                      child: StyledText(
                                        text: 'Resend OTP ? <red>(0:30)</red>',
                                        styles: {
                                          'red': TextStyle(
                                            color: Colors.red,
                                          ),
                                        },
                                      )))
                            ])))
                  ])),
        ));
  }
}
