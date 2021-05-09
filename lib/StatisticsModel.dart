import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StatisticsModel extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void updateOpenedRef() async {
    print("Updating stastics of open");
    DocumentReference totalOpenedRef =
        firestore.collection("TotalOpened").doc("value");
    DateTime now = DateTime.now();
    String dateRef = now.day.toString() +
        "-" +
        (now.month + 1).toString() +
        "-" +
        now.year.toString();
    DocumentReference dailyRef =
        firestore.collection("DailyOpenedStats").doc(dateRef);
    totalOpenedRef.set({
      "total": FieldValue.increment(1),
      "last_updated": now.millisecondsSinceEpoch
    }, SetOptions(merge: true)).then((value) {
      print("Updated Total OpenedStats");
    }).catchError((e) {
      print(e);
    });
    dailyRef.set({
      "total": FieldValue.increment(1),
      "string_val": dateRef,
      "date": now.millisecondsSinceEpoch
    }, SetOptions(merge: true)).then((value) {
      print("Updated daily opened stat");
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  void updateCatOpenedStats(String catId) {
    DateTime now = DateTime.now();
    String dateString = now.day.toString() +
        "-" +
        (now.month + 1).toString() +
        "-" +
        (now.year.toString());
    DocumentReference ref = firestore.collection("CategoryStats").doc(catId);
    DocumentReference dailyStatsRef = firestore
        .collection("CategoryDailyStats")
        .doc(dateString + "-" + catId);
    Map<String, dynamic> toUpdate = {
      "cat_id": catId,
      "no_of_times_opened": FieldValue.increment(1),
      "last_updated": DateTime.now().millisecondsSinceEpoch,
    };
    Map<String, dynamic> dailyStatToUpdate = {
      "cat_id": catId,
      "no_of_times_opened": FieldValue.increment(1),
      "date": DateTime.now().millisecondsSinceEpoch,
      "date_string": dateString,
    };
    dailyStatsRef.set(dailyStatToUpdate, SetOptions(merge: true)).then((val) {
      print("Daily cat stats updated");
    }).onError((error, stackTrace) {
      print(error);
    });
    ref.set(toUpdate, SetOptions(merge: true)).then((value) {
      print("Category Open status updated");
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}
