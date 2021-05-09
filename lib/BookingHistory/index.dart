import 'package:flutter/material.dart';
import 'package:nivishka_android/util/index.dart';
import 'Bookings.dart';
import 'package:provider/provider.dart';
import 'BookingHistoryModel.dart';

class BookingHistory extends StatefulWidget {
  @override
  State<BookingHistory> createState() => _BookingHistory();
}

class _BookingHistory extends State<BookingHistory> {
  @override
  @protected
  void initState() {
    super.initState();
    var bookingModel = Provider.of<BookingHistoryModel>(context, listen: false);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => {bookingModel.getPendingOrderData()});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var bookingModel = Provider.of<BookingHistoryModel>(context);
    return SafeArea(
        top: true,
        bottom: true,
        child: DefaultTabController(
            length: 3,
            child: WillPopScope(
                onWillPop: () async {
                  Navigator.pushNamed(context, "/home");
                  return false;
                },
                child: Scaffold(
                    bottomNavigationBar: CustomBottomNavBar(selectedIndex: 1),
                    appBar: AppBar(
                      backgroundColor: primaryColor,
                      leading: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, "/home");
                          },
                          child: Icon(Icons.arrow_back,
                              color: Colors.black, size: 20)),
                      title: Text("My Bookings",
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 14)),
                      bottom: TabBar(
                        labelStyle: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        unselectedLabelStyle: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.black87,
                            fontWeight: FontWeight.normal),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.black54,
                        indicatorColor: Colors.green[800],
                        onTap: (int index) {
                          switch (index) {
                            case 0:
                              bookingModel.getPendingOrderData();
                              break;
                            case 1:
                              bookingModel.getCompletedOrderData();
                              break;
                            case 2:
                              bookingModel.getCancelledOrderData();
                              break;
                          }
                        },
                        tabs: [
                          Tab(text: "Scheduled"),
                          Tab(text: "Completed"),
                          Tab(text: "Cancelled"),
                        ],
                      ),
                    ),
                    body: Container(
                        height: height,
                        width: width,
                        child: TabBarView(children: [
                          (!bookingModel.isScheduledLoading)
                              ? Bookings(
                                  type: "pending",
                                  ordersData: bookingModel.pendingOrders,
                                )
                              : Container(
                                  height: 100,
                                  width: width,
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                      children: [CircularProgressIndicator()])),
                          (!bookingModel.isCompletedLoading)
                              ? Bookings(
                                  type: "completed",
                                  ordersData: bookingModel.completedOrders,
                                )
                              : Container(
                                  height: 100,
                                  width: width,
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                      children: [CircularProgressIndicator()])),
                          (!bookingModel.isCancelledLoading)
                              ? Bookings(
                                  type: "cancelled",
                                  ordersData: bookingModel.cancelledOrders,
                                )
                              : Container(
                                  height: 100,
                                  width: width,
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                      children: [CircularProgressIndicator()])),
                        ]))))));
  }
}
