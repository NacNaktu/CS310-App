import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class PostService {
  final FirebaseFirestore _firestore;

  PostService(this._firestore);

  Future<dynamic> getAllUserPostsId(String userId) async {
    dynamic list;
    await _firestore
        .collection('postList')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // print(documentSnapshot["postList"]);
        list = documentSnapshot["postList"];
      } else {
        print("user does not exist");
      }
    });

    return list;
  }

  Future<void> savePost(String description, File image, String userId) async {
    String url = await uploadToStorage(image);
    String post1Id = DateTime.now().millisecondsSinceEpoch.toString();
    DocumentReference post1 =
        FirebaseFirestore.instance.collection('post').doc(post1Id + "aaaaaa");
    post1.set({
      //TODO id degisecek
      "userId": userId,
      "description": description,
      "imageUrl": url,
      "date": DateTime.now().toString(),
      "likedUsers": [],
      "commentList": []
      ,"dislikedUsers":[]
    });
    // //TODO id degisecek
    DocumentReference postList =
        FirebaseFirestore.instance.collection('postList').doc(userId);
    postList.update({
      "postList": FieldValue.arrayUnion([post1Id])
    });
  }

  Future<String> uploadToStorage(File image) async {
    String tempUrl;

    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    firebase_storage.Reference reference =
        firebase_storage.FirebaseStorage.instance.ref().child(imageName);
    firebase_storage.UploadTask uploadTask = reference.putFile(image);
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
    await taskSnapshot.ref.getDownloadURL().then((url) {
      print(url);
      tempUrl = url;
    });
    return tempUrl;
  }

  Future<void> likePost(String postId, String userId) async {
    print("icerde");
    await _firestore
        .collection('post')
        .doc(postId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      List<dynamic> list = documentSnapshot["dislikedUsers"];
      if (list.contains(userId)) {
        _firestore.collection('post').doc(postId).update({
          "dislikedUsers": FieldValue.arrayRemove([userId])
        });
      }
    });

    await _firestore
        .collection('post')
        .doc(postId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // print(documentSnapshot["postList"]);
        List<dynamic> list = documentSnapshot["likedUsers"];
        if (list.contains(userId)) {
          print("Post is already liked");
        } else {
          _firestore.collection('post').doc(postId).update({
            "likedUsers": FieldValue.arrayUnion([userId])
          });
        }
      } else {
        print("Post does not exist");
      }
    });
  }

  Future<void> dislikePost(String postId, String userId) async {
    print("icerde");
    await _firestore
        .collection('post')
        .doc(postId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      List<dynamic> list = documentSnapshot["likedUsers"];
      if (list.contains(userId)) {
        _firestore.collection('post').doc(postId).update({
          "likedUsers": FieldValue.arrayRemove([userId])
        });
      }
    });

    await _firestore
        .collection('post')
        .doc(postId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // print(documentSnapshot["postList"]);
        List<dynamic> list = documentSnapshot["dislikedUsers"];
        if (list.contains(userId)) {
          print("Post is already disliked");
        } else {
          _firestore.collection('post').doc(postId).update({
            "dislikedUsers": FieldValue.arrayUnion([userId])
          });
        }
      } else {
        print("Post does not exist");
      }
    });
  }
}
