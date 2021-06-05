import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_app/utils/classes.dart' as classes;
import 'package:cs310_app/utils/grid_view.dart';
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

  Future<void> getAllUser() async {
    List<classes.User> tempList = [];
    print("icerde");
    print("**********************");

    await _firestore.collection("users").get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        classes.User tempUser = classes.User(username: doc["username"],surname: doc["surname"],name: doc["name"]);
        tempUser.id = doc.id;
        tempList.add(tempUser);

      });
    });

    searchUser = tempList;
    await Future.delayed(Duration(milliseconds: 200));
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

  Future<bool> getActiveStatus(String userId) async {
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
