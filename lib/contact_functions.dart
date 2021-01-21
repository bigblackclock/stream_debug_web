import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class ContactFunctions {
  ContactFunctions({FirebaseFirestore firestore})
      : _contactsRef =
            (firestore ?? FirebaseFirestore.instance).collection('contacts');

  final CollectionReference _contactsRef;

  Stream contacts() {
    return _contactsRef.snapshots().asBroadcastStream();
  }
}
