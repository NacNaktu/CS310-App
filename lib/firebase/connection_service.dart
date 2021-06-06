import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/variables.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

class ConnectionService {
  final FirebaseFirestore _firestore;

  ConnectionService(this._firestore);

  Future<void> removeConnection(String personId, String userId) async {


    await _firestore
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {

        List<dynamic> list = documentSnapshot["connections"];
        if (list.contains(personId)) {
          print("Not Connected");
          _firestore.collection('users').doc(userId).update({
            "connections": FieldValue.arrayRemove([personId])
          });
        }
      } else {
        print("Person does not exist");
      }
    });
  }

}