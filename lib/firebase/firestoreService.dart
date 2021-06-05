import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

class FirestoreServicee {
  final FirebaseFirestore _firestore;

  FirestoreServicee(this._firestore);

  Future<String> getUserData(String userId, String fieldName) async {
    String temp;
    await _firestore
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        temp = documentSnapshot[fieldName];
      } else {
        print("user does not exist");
      }
    });
    return temp;
  }

  void deactivateUser(String userId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .set({"active": false}, SetOptions(merge: true));
  }

  void deleteUser(String userId) async {
    await _firestore.collection('users').doc(userId).delete();
  }

  Future<bool>  getActiveStatus (String userId) async {
    bool temp;
    await _firestore
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        temp = documentSnapshot["active"];
      } else {
        print("user does not exist");
      }
    });
    print(temp);
    return temp;

  }

  Future<bool> updateUserField(
      String userId, String fieldName, dynamic newValue) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .set({fieldName: newValue}, SetOptions(merge: true));
  }



  Future<bool> getVisible(String userId) async {
    bool temp;
    await _firestore
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        temp = documentSnapshot["visible"];
      } else {
        print("user does not exist");
      }
    });
    return temp;
  }

  Future<bool> changeVisible(String userId, bool value) async {
    bool temp;
    await _firestore
        .collection('users')
        .doc(userId)
        .set({"visible": value}, SetOptions(merge: true));


  }

  Future<void> changePicture(String userId, String url) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .set({"imageUrl": url}, SetOptions(merge: true));
  }
}
