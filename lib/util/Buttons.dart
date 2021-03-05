import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget shadowButton({
  double height = 40,
  double width = 70,
  Color color,
  Color shadowColor,
  String text,
  double fontSize = 12,
  Color fontColor,
  FontWeight fontWeight,
  Function ontap,
}) {
  return InkWell(
      onTap: ontap,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Container(
              height: height,
              width: width,
              padding: EdgeInsets.all(5),
              margin: const EdgeInsets.only(bottom: 3.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: shadowColor,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Center(
                  child: Text("$text",
                      style: GoogleFonts.poppins(
                          fontWeight: fontWeight,
                          fontSize: fontSize,
                          color: fontColor))))));
}

Widget normalButton({
  double height = 40,
  double width = 70,
  Color color,
  String text,
  double fontSize = 12,
  List<BoxShadow> shadow,
  BoxBorder border,
  Color fontColor,
  FontWeight fontWeight,
  Function ontap,
}) {
  return InkWell(
      onTap: ontap,
      child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(5),
          margin: const EdgeInsets.only(bottom: 3.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
            boxShadow: shadow,
            border: border,
          ),
          child: Center(
              child: Text("$text",
                  style: GoogleFonts.poppins(
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                      color: fontColor)))));
}

Widget gradientButton({
  double height = 40,
  double width = 70,
  Gradient gradient,
  List<BoxShadow> shadow,
  String text,
  BoxBorder border,
  double fontSize = 12,
  Color fontColor,
  FontWeight fontWeight,
  Function ontap,
}) {
  return InkWell(
      onTap: ontap,
      child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(5),
          margin: const EdgeInsets.only(bottom: 3.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: gradient,
              boxShadow: shadow,
              border: border),
          child: Center(
              child: Text("$text",
                  style: GoogleFonts.poppins(
                      fontWeight: fontWeight,
                      fontSize: fontSize,
                      color: fontColor)))));
}
