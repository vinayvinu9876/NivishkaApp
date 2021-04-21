import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:provider/provider.dart';
import "SelectCityModel.dart";

class SelectCity extends StatefulWidget {
  @override
  State<SelectCity> createState() => _SelectCity();
}

class _SelectCity extends State<SelectCity> {
  @override
  void initState() {
    super.initState();
    var selectCityModel = Provider.of<SelectCityModel>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => selectCityModel.getCityData());
  }

  @override
  Widget build(BuildContext context) {
    var selectCityModel = Provider.of<SelectCityModel>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            bottomNavigationBar: nextButton(
                isActive: (selectCityModel.selectedCityCode != null)),
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: Text("Select City",
                  style:
                      GoogleFonts.poppins(color: Colors.black, fontSize: 14)),
              centerTitle: true,
            ),
            body: Container(
                padding: EdgeInsets.only(top: 15, right: 15, left: 15),
                height: height,
                width: width,
                child: ListView(children: [
                  Visibility(
                      visible: (selectCityModel.errorMessage != null),
                      child: Text("${selectCityModel.errorMessage}",
                          style: GoogleFonts.poppins(
                              color: Colors.red, fontSize: 10))),
                  for (var item in selectCityModel.cityData)
                    InkWell(
                      onTap: () {
                        selectCityModel.setCity(item["city_name"]);
                      },
                      child: cityWidget(
                          imgUrl: "${item["imgUrl"]}",
                          name: "${item["city_name"]}",
                          active: (item["city_name"] ==
                              selectCityModel.selectedCityCode)),
                    ),
                ]))));
  }

  Widget nextButton({bool isActive = false}) {
    double width = MediaQuery.of(context).size.width;
    var selectCityModel = Provider.of<SelectCityModel>(context);
    return InkWell(
        onTap: () {
          if (isActive) selectCityModel.updateCityCode();
        },
        child: Container(
            height: 50,
            width: width,
            color: isActive ? Colors.green[800] : Colors.grey[200],
            child: Center(
                child: selectCityModel.isLoading
                    ? CircularProgressIndicator()
                    : Text("Next",
                        style: GoogleFonts.poppins(
                            color: isActive ? Colors.white : Colors.black38,
                            fontSize: 14,
                            fontWeight: isActive
                                ? FontWeight.bold
                                : FontWeight.normal)))));
  }

  Widget cityWidget(
      {@required String imgUrl, @required String name, bool active = false}) {
    return Container(
        height: 55,
        margin: EdgeInsets.only(top: 7, bottom: 7),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: active ? Colors.green[800] : Colors.green[200],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                      padding: EdgeInsets.all(2),
                      child: active
                          ? CircleAvatar(
                              backgroundColor: Colors.green[300],
                              child: Icon(Icons.done, color: Colors.white),
                            )
                          : CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage("$imgUrl")))),
              SizedBox(width: 15),
              Expanded(
                  flex: 8,
                  child: Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("$name",
                                style: GoogleFonts.poppins(
                                    color:
                                        active ? Colors.white : Colors.black38,
                                    fontSize: 14))
                          ])))
            ]));
  }
}
