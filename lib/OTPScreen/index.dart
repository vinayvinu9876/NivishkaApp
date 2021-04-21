import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:styled_text/styled_text.dart';
import 'package:provider/provider.dart';
import "OTPModel.dart";

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen({@required this.phone});
  @override
  State<OTPScreen> createState() => _OTPScreen(phone: phone);
}

class _OTPScreen extends State<OTPScreen> {
  final String phone;
  _OTPScreen({@required this.phone});

  @override
  @protected
  void initState() {
    super.initState();
    var otpModel = Provider.of<OTPModel>(context, listen: false);
    print("Phone recevied at otp screen is $phone");
    WidgetsBinding.instance
        .addPostFrameCallback((_) => {otpModel.setPhoneNo(phone)});
  }

  @override
  void dispose() {
    super.dispose();
    var otpModel = Provider.of<OTPModel>(context, listen: false);
    otpModel.cancelListeners();
  }

  @override
  Widget build(BuildContext context) {
    var otpModel = Provider.of<OTPModel>(context);
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
                                  otpModel.setOTP(pin);
                                },
                              ),
                              SizedBox(height: 40),
                              otpModel.isLoading
                                  ? Container(
                                      height: 60,
                                      width: 60,
                                      child: Column(children: [
                                        CircularProgressIndicator()
                                      ]))
                                  : gradientButton(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width *
                                          0.7,
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
                                      ontap: () => {otpModel.verifyOTP()},
                                    ),
                              SizedBox(height: 20),
                              Center(
                                  child: InkWell(
                                      onTap: () {
                                        if (otpModel.nextOTPDelay == 0)
                                          otpModel.resendOTP();
                                      },
                                      child: StyledText(
                                        text: otpModel.nextOTPDelay == 0
                                            ? 'Resend OTP ? <red>Click here</red>'
                                            : 'Resend OTP ? <red>(${otpModel.nextOTPDelay} seconds)</red>',
                                        styles: {
                                          'red': TextStyle(
                                            color: Colors.red,
                                          ),
                                        },
                                      ))),
                              SizedBox(height: 10),
                              Visibility(
                                  visible: otpModel.errorMessage != null,
                                  child: Center(
                                      child: Text("${otpModel.errorMessage}",
                                          style: GoogleFonts.poppins(
                                              color: Colors.red,
                                              fontSize: 10))))
                            ])))
                  ])),
        ));
  }
}
