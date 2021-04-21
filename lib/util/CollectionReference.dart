import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

Map<String, CollectionReference> collections = {
  "category": firestore.collection("Category"),
  "city": firestore.collection("City"),
  "partner": firestore.collection("Partner"),
  "promo": firestore.collection("service"),
  "users": firestore.collection("Users"),
  "voucher": firestore.collection("Voucher"),
};
