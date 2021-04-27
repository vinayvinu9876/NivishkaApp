import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:nivishka_android/Login/LoginModel.dart';

class EnterPhone extends StatefulWidget {
  @override
  State<EnterPhone> createState() => _EnterPhone();
}

class _EnterPhone extends State<EnterPhone> {
  @override
  Widget build(BuildContext context) {
    var phoneModel = Provider.of<LoginModel>(context);
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
                            phoneTextField(
                                placeholder: "Enter Phone",
                                maxLength: 10,
                                onChange: (phone) {
                                  phoneModel.setPhone(phone);
                                }),
                            SizedBox(height: 20),
                            Visibility(
                              visible: phoneModel.isLoading,
                              child: Center(child: CircularProgressIndicator()),
                            ),
                            Visibility(
                                visible: !phoneModel.isLoading,
                                child: gradientButton(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
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
                                  border: Border.all(
                                      color: Colors.white30, width: 1.0),
                                  text: "LOGIN",
                                  fontSize: 14,
                                  fontColor: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  ontap: () => {phoneModel.login()},
                                )),
                            SizedBox(height: 10),
                            Visibility(
                                visible: phoneModel.errorMessage != null,
                                child: Text("${phoneModel.errorMessage}",
                                    style: GoogleFonts.poppins(
                                        color: Colors.red, fontSize: 10))),
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

  Widget phoneTextField({
    @required String placeholder,
    int maxLength,
    Function onChange,
  }) {
    return IntlPhoneField(
      //controller: controller,
      countries: ["IN"],
      autofocus: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(5),
        labelText: 'Phone Number',
        labelStyle: GoogleFonts.poppins(fontSize: 10),
      ),
      initialCountryCode: 'IN',
      onChanged: (phone) {
        print(phone.completeNumber);
        String nextPhone = phone.completeNumber.substring(3);
        print("Removed country code $nextPhone");
        onChange(nextPhone);
      },
    );
  }
}
