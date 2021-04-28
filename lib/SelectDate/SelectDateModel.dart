import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nivishka_android/util/index.dart';

class SelectDateModel extends ChangeNotifier {
  bool _isLoading = false;
  int _start = 0, _end = 0, _diff = 0;
  DateTime _selectedDate;

  bool get isLoading => _isLoading;
  DateTime get selectedDate => _selectedDate;
  int get start => _start;
  int get end => _end;
  int get diff => _diff;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void getStartAndEndTime() {
    _isLoading = true;
    notifyListeners();

    DocumentReference docRef = firestore.collection("Time").doc("time");

    docRef.get().then((DocumentSnapshot doc) {
      _isLoading = false;
      Map<String, dynamic> data = doc.data();
      _start = data["start_time"];
      _end = data["end_time"];
      _diff = data["difference"];
      notifyListeners();
    }).catchError((err) {
      print(err);
      _isLoading = false;
      notifyListeners();
    });
  }
}
