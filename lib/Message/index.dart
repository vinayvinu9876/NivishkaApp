import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';

class Message extends StatefulWidget {
  final String message;
  final IconData icon;
  final bool backActive;
  Message(
      {@required this.message, @required this.icon, this.backActive = false});
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (widget.backActive) {
              Navigator.pop(context);
              return;
            }
            Navigator.pushNamed(context, "/home");
          },
          child: widget.backActive
              ? Icon(Icons.arrow_back, color: Colors.white)
              : Icon(Icons.home, color: Colors.white),
        ),
        body: Container(
            height: height,
            width: width,
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
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ))));
  }
}
