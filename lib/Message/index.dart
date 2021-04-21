import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class Message extends StatefulWidget {
  final String message;
  final IconData icon;
  Message({@required this.message, @required this.icon});
  @override
  State<Message> createState() => _Message(message: message, icon: icon);
}

class _Message extends State<Message> {
  final String message;
  final IconData icon;
  _Message({@required this.message, @required this.icon});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(),
            child: Container(
                height: height,
                width: width,
                padding: EdgeInsets.all(35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: 35,
                        child: Container(
                            padding: EdgeInsets.all(5),
                            child: Icon(
                              icon,
                              size: 35,
                            ))),
                    SizedBox(height: 20),
                    Text("$message",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ))));
  }
}
