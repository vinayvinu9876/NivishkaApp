import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nivishka_android/util/index.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:nivishka_android/AppServices/NavigatorService.dart';
import 'package:nivishka_android/AppServices/services.dart';

class SelectLocationModel extends ChangeNotifier {
  bool _isLoading = false;

  dynamic _currentPosition; //can be LatLng or Position object
  String _placeName;
  String _building;
  String _name;
  String _pincode;
  String _addressType;
  String _errorMessage;

  bool get isLoading => _isLoading;
  Position get currentPosition => _currentPosition;
  String get placeName => _placeName;
  String get building => _building;
  String get name => _name;
  String get addressType => _addressType;
  String get errorMessage => _errorMessage;
  String get pincode => _pincode;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFunctions func = FirebaseFunctions.instance;

  void setCurrentPosition(position) async {
    final coordinates = new Coordinates(position.latitude, position.longitude);
    List<Address> addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    _placeName = addresses.first.addressLine;
    _currentPosition = Position(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: 10,
        speed: 10,
        speedAccuracy: 10,
        timestamp: DateTime.now(),
        altitude: 10,
        heading: 10);
    notifyListeners();
  }

  void setBuilding(String buildingName) {
    _building = buildingName;
    notifyListeners();
  }

  void setName(String nameVal) {
    _name = nameVal;
    notifyListeners();
  }

  void setAddressType(String addressTypeVal) {
    _addressType = addressTypeVal;
    notifyListeners();
  }

  void setPinCode(String pincode) {
    _pincode = pincode;
    notifyListeners();
  }

  void updateLocation() {
    _errorMessage = null;
    notifyListeners();

    if (isEmpty(_placeName)) {
      _errorMessage = "Place name cannot be empty";
      notifyListeners();
      return;
    }
    if (isEmpty(_currentPosition)) {
      _errorMessage = "Please Select a location";
      notifyListeners();
      return;
    }

    if (isEmpty(_name)) {
      _errorMessage = "Name cannot be empty";
      notifyListeners();
      return;
    }

    if (isEmpty(_building)) {
      _errorMessage = "Building cannot be empty";
      notifyListeners();
      return;
    }

    if (isEmpty(_addressType)) {
      _errorMessage = "Address Type cannot be empty";
      notifyListeners();
      return;
    }

    if (isEmpty(_pincode)) {
      _errorMessage = "Pin code cannot be empty";
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    String uid = auth.currentUser.uid;

    HttpsCallable callable = func.httpsCallable("updateLocationOnOrder");

    callable({
      "uid": uid,
      "placeName": _placeName,
      "name": _name,
      "building": _building,
      "addressType": _addressType,
      "lat": _currentPosition.latitude,
      "lng": _currentPosition.longitude,
      "pincode": _pincode,
    }).then((HttpsCallableResult res) async {
      print("Result = ${res.data}");
      if (res.data["status"] == "success") {
        _isLoading = false;
        await getIt<NavigationService>().navigateTo("/selectDate");
        notifyListeners();
        return;
      }
      _errorMessage = res.data["message"];
      _isLoading = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      print("$error");
      _isLoading = false;
      _errorMessage = error.message;
      notifyListeners();
    });
  }
}
