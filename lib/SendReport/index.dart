import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:nivishka_android/SendReport/SendReportModel.dart';
import 'package:provider/provider.dart';

class SendReport extends StatefulWidget {
  @override
  State<SendReport> createState() => _SendReport();
}

class _SendReport extends State<SendReport> {
  TextEditingController detailsController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var sendModel = Provider.of<SendReportModel>(context);
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: Text("Send Report",
                  style:
                      GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
            ),
            body: Container(
                height: height,
                width: width,
                padding: EdgeInsets.all(15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter Details",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 15),
                      Container(
                          child: TextField(
                              controller: detailsController,
                              onChanged: sendModel.setDetails,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 10),
                              decoration: InputDecoration(
                                hintText:
                                    "Please Tell us more about your trouble",
                                hintStyle: GoogleFonts.poppins(fontSize: 10),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.black)),
                              ))),
                      SizedBox(height: 15),
                      Text("Contact Phone",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 15),
                      TextField(
                          controller: phoneController,
                          onChanged: sendModel.setPhone,
                          maxLength: 10,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: false, decimal: false),
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 10),
                          decoration: InputDecoration(
                            hintText: "Phone",
                            hintStyle: GoogleFonts.poppins(fontSize: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.black)),
                          )),
                      SizedBox(height: 15),
                      ElevatedButton(
                          child: Text(
                              sendModel.isLoading ? "Sending.." : "Send Report",
                              style: GoogleFonts.poppins(color: Colors.white)),
                          onPressed: () {
                            if (!sendModel.isLoading) sendModel.sendReport();
                          }),
                      SizedBox(height: 10),
                      Visibility(
                        visible: sendModel.errorMessage != null,
                        child: Text("${sendModel.errorMessage}",
                            style: GoogleFonts.poppins(
                                color: Colors.red, fontSize: 12)),
                      ),
                      Visibility(
                          visible: sendModel.errorMessage == null,
                          child:
                              Text("We promise to respond as soon as possible",
                                  style: GoogleFonts.poppins(
                                    color: Colors.green[800],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  )))
                    ]))));
  }
}
