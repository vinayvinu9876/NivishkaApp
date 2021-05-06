import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import "../Wallet/WalletModel.dart";
import 'package:provider/provider.dart';
import 'TopUpWalletModel.dart';

class TopUpWallet extends StatefulWidget {
  @override
  State<TopUpWallet> createState() => _TopUpWallet();
}

class _TopUpWallet extends State<TopUpWallet> {
  TextEditingController input = new TextEditingController();

  @override
  void initState() {
    super.initState();
    var walletModel = Provider.of<WalletModel>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => walletModel.getWalletData());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
            body: Container(
                height: height,
                width: width,
                child: ListView(children: [
                  topBar(),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                      child: Center(
                          child: Text("Select an amount to top up",
                              style: GoogleFonts.poppins(
                                color: Colors.black87,
                                fontSize: 12,
                              )))),
                  SizedBox(height: 10),
                  Container(
                      height: 120,
                      width: width,
                      padding: EdgeInsets.all(10),
                      child:
                          ListView(scrollDirection: Axis.horizontal, children: [
                        rechargeAmountSelect(
                          displayNo: 1,
                          cost: 100,
                        ),
                        rechargeAmountSelect(
                          displayNo: 2,
                          cost: 200,
                        ),
                        rechargeAmountSelect(
                          displayNo: 5,
                          cost: 500,
                        ),
                        rechargeAmountSelect(
                          displayNo: 1,
                          cost: 1000,
                        ),
                      ])),
                  Container(
                      padding: EdgeInsets.all(15),
                      width: width,
                      child: Center(
                          child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: Center(
                                  child: Text("OR",
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: Colors.grey[500])))))),
                  customEnterAmount()
                ]))));
  }

  Widget customEnterAmount() {
    var topUpWalletModel = Provider.of<TopUpWalletModel>(context);

    input.text = topUpWalletModel.topUpValue == null
        ? ""
        : topUpWalletModel.topUpValue.toString();
    if (input.text != null)
      input.selection =
          TextSelection.fromPosition(TextPosition(offset: input.text.length));

    void onChange(String txt) {
      if (txt == null) {
        topUpWalletModel.setTopUpValue(null);
        return;
      }
      double val = double.parse(txt);
      topUpWalletModel.setTopUpValue(val.toInt());
    }

    return Container(
        padding: EdgeInsets.all(15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Enter other amount",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14,
                  )),
              Container(
                  child: TextField(
                      controller: input,
                      onChanged: onChange,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: false, decimal: false),
                      decoration: InputDecoration(
                          errorText: topUpWalletModel.errorMessage,
                          hintText: "₹ 0.00",
                          hintStyle: GoogleFonts.poppins(
                              color: Colors.grey[400], fontSize: 18)))),
              SizedBox(height: 30),
              InkWell(
                  onTap: () {
                    topUpWalletModel.addMoneyToWallet();
                  },
                  child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.green,
                          child: Center(
                              child: topUpWalletModel.isLoading
                                  ? CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.white))
                                  : Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    )))))
            ]));
  }

  Widget rechargeAmountSelect(
      {@required double displayNo, @required int cost}) {
    bool isActive = false;

    var topUpWalletModel = Provider.of<TopUpWalletModel>(context);

    if (topUpWalletModel.topUpValue == cost) {
      isActive = true;
    }
    return InkWell(
        onTap: () {
          topUpWalletModel.setTopUpValue(cost);
        },
        child: Container(
            height: 120,
            width: 100,
            margin: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    width: 0.8,
                    color: isActive ? Colors.green[500] : Colors.grey[200])),
            child: Stack(children: [
              Container(
                  width: 100,
                  height: 120,
                  padding: EdgeInsets.all(5),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("$displayNo",
                            style: GoogleFonts.poppins(
                                fontSize: 59, color: Colors.grey[100]))
                      ])),
              Container(
                  width: 100,
                  height: 120,
                  padding: EdgeInsets.all(15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                            radius: 10,
                            backgroundColor:
                                isActive ? Colors.green[500] : Colors.black,
                            child: Center(
                              child: isActive
                                  ? Icon(Icons.done,
                                      size: 14, color: Colors.white)
                                  : CircleAvatar(
                                      radius: 9,
                                      backgroundColor: Colors.white,
                                    ),
                            )),
                        Text("₹ $cost",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold))
                      ]))
            ])));
  }

  Widget topBar() {
    var walletModel = Provider.of<WalletModel>(context);
    double width = MediaQuery.of(context).size.width;
    return Container(
        child: Stack(children: [
      Container(
          padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 5),
          child: Container(
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20)))),
      Container(
          padding: EdgeInsets.only(top: 20, left: 45, right: 45, bottom: 5),
          child: Container(
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20)))),
      Container(
          height: 120,
          width: width,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.green[500],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25))),
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                    child: Row(children: [
                  Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back, color: Colors.white))),
                  Expanded(
                      flex: 8,
                      child: Center(
                          child: Text("Top up Wallet",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)))),
                  Expanded(flex: 1, child: Container())
                ])),
                SizedBox(height: 25),
                Container(
                    width: width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text("My Wallet Balance",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ])),
                          Text(
                              "₹ ${walletModel.walletData == null ? "NA" : walletModel.walletData["wallet_balance"] / 100}",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                        ])),
              ]))),
    ]));
  }
}
