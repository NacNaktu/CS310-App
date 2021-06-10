import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/variables.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart';
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
    getAllUserPost(list);
    return list;
  }

  Future<Void> getAllUserPost(List<dynamic> postIdList) async {
    List<Post> returnList = [];
    for (var temp in postIdList) {
      await _firestore
          .collection('post')
          .doc(temp)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print(documentSnapshot["description"]);
          _firestore
              .collection("users")
              .doc(documentSnapshot["userId"])
              .get()
              .then((DocumentSnapshot documentSnapshot1) {
            print(documentSnapshot1);
            User tempUser = User(
                name: documentSnapshot1["name"],
                surname: documentSnapshot1["surname"],
                username: documentSnapshot1["username"]);
            tempUser.id = documentSnapshot["userId"];
            Post tempPost = Post(
                description: documentSnapshot["description"],
                image: documentSnapshot["imageUrl"],
                sender: tempUser);
            tempPost.id = temp;
            tempPost.likedUsers = documentSnapshot["likedUsers"];
            tempPost.dislikedUsers = documentSnapshot["dislikedUsers"];
            returnList.add(tempPost);
            print("deneme123");
          });
        } else {
          print("post does not exist");
        }
      });
    }
    print("////////////////////////////");
    print(returnList.length);
    print(returnList);
    LoggedUser.shared = returnList;
  }

  Future<void> savePost(String description, File image, String userId) async {
    String url = await uploadToStorage(image);
    String post1Id = DateTime.now().millisecondsSinceEpoch.toString();
    DocumentReference post1 =
        FirebaseFirestore.instance.collection('post').doc(post1Id);
    post1.set({
      //TODO id degisecek
      "userId": userId,
      "description": description,
      "imageUrl": url,
      "date": DateTime.now().toString(),
      "likedUsers": [],
      "commentList": [], "dislikedUsers": []
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
    print(' icerde like');
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
          _firestore.collection('post').doc(postId).update({
            "likedUsers": FieldValue.arrayRemove([userId])
          });
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
          _firestore.collection('post').doc(postId).update({
            "dislikedUsers": FieldValue.arrayRemove([userId])
          });
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

  Future<void> bookmarkPost(String postId, String userId) async {


    await _firestore
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // print(documentSnapshot["postList"]);
        List<dynamic> list = documentSnapshot["bookmarkList"];
        if (list.contains(postId)) {
          print("Post is already disliked");
          _firestore.collection('users').doc(userId).update({
            "bookmarkList": FieldValue.arrayRemove([postId])
          });
        } else {
          _firestore.collection('users').doc(userId).update({
            "bookmarkList": FieldValue.arrayUnion([postId])
          });
        }
      } else {
        print("Post does not exist");
      }
    });
  }

  Future<void> resharePost(String postId, String userId) async {
    await _firestore
        .collection('post')
        .doc(postId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        String userOfPost = documentSnapshot["bookmarkList"];
        if (userOfPost == LoggedUser.id) {
          print("You cant reshare your own posts");
        } else {
          _firestore
              .collection('postList')
              .doc(userId)
              .get()
              .then((DocumentSnapshot documentSnapshot1) {
            List<dynamic> list = documentSnapshot1["postList"];
            if (list.contains(postId)) {
              print("post already shared, removing from share list");
              _firestore.collection('postList').doc(userId).update({
                "postList": FieldValue.arrayRemove([postId])
              });
            } else {
              print("addiing post to postlist");
              _firestore.collection('postList').doc(userId).update({
                "postList": FieldValue.arrayUnion([postId])
              });
            }
          });
        }
      } else {
        print("Post does not exist");
      }
    });
  }
  Future<void> removePost(String postId, String userId) async {


    await _firestore
        .collection('post')
        .doc(postId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        _firestore
            .collection('postList')
            .doc(postId).delete();


      } else {
        print("Post does not exist");
      }
    });

    await _firestore
        .collection('postList')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        _firestore.collection('postList').doc(userId).update({
          "postList": FieldValue.arrayRemove([postId])});


      } else {
        print("Post does not exist");
      }
    });
  }

  Future<void> editPost(String postId, String image, String description) async {


    await _firestore
        .collection('post')
        .doc(postId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {

        if (image != ""){
          FirebaseFirestore.instance.collection('post').doc(postId).set({'imageUrl' : image});
        }
        if (image != ""){
          FirebaseFirestore.instance.collection('post').doc(postId).set({'description' : description});
        }



      } else {
        print("Post does not exist");
      }
    });


  }
}
