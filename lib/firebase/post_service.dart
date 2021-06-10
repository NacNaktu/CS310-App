import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/grid_view.dart';
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
    getAllUserPost(list, "profile");
    return list;
  }

  Future<Void> getAllUserPost(List<dynamic> postIdList, String type) async {
    List<Post> returnList = [];
    for (var temp in postIdList) {
      await _firestore
          .collection('post')
          .doc(temp)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          await _firestore
              .collection("users")
              .doc(documentSnapshot["userId"])
              .get()
              .then((DocumentSnapshot documentSnapshotUser) {
            User tempUser = User(
                name: documentSnapshotUser["name"],
                surname: documentSnapshotUser["surname"],
                username: documentSnapshotUser["username"]);
            tempUser.id = documentSnapshot["userId"];
            tempUser.image = documentSnapshotUser["imageUrl"];
            Post tempPost = Post(
                description: documentSnapshot["description"],
                image: documentSnapshot["imageUrl"],
                sender: tempUser);
            tempPost.id = temp;
            tempPost.likedUsers = documentSnapshot["likedUsers"];
            tempPost.dislikedUsers = documentSnapshot["dislikedUsers"];
            returnList.add(tempPost);
          });
        } else {
          print("post does not exist");
        }
      });
    }

    if (type == "profile") {
      LoggedUser.shared = returnList;
      profilePost = returnList;
    } else {
      feedPost = returnList;
    }
    await Future.delayed(Duration(seconds: 3));
  }

  Future<void> savePost(String description, File image, String userId) async {
    String url = await uploadToStorage(image);
    String post1Id = DateTime.now().millisecondsSinceEpoch.toString();
    DocumentReference post1 =
        FirebaseFirestore.instance.collection('post').doc(post1Id);
    post1.set({
      "userId": userId,
      "description": description,
      "imageUrl": url,
      "date": DateTime.now().toString(),
      "likedUsers": [],
      "commentList": [],
      "dislikedUsers": []
    });
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
      tempUrl = url;
    });
    return tempUrl;
  }

  Future<void> likePost(String postId, String userId) async {
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
        _firestore.collection('postList').doc(postId).delete();
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
          "postList": FieldValue.arrayRemove([postId])
        });
      } else {
        print("Post does not exist");
      }
    });
  }

  Future<void> editPost(String postId, String description) async {
    print("************************************");
    print(postId);
    await _firestore
        .collection('post')
        .doc(postId)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        if (description != "") {
          await _firestore
              .collection('post')
              .doc(postId)
              .update({'description': description});
        }
      } else {
        print("Post does not exist");
      }
    });
  }

  Future<dynamic> getAllUserAndFollowingPostsId(String userId) async {
    List<dynamic> followingList;
    List<dynamic> postList = [];

    followingList = LoggedUser.connections;
    for (var temp in followingList) {
      await _firestore
          .collection('postList')
          .doc(temp)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          postList.addAll(documentSnapshot["postList"]);
        } else {
          print("user does not exist");
        }
      });
    }
    print(postList.length);
    await getAllUserPost(postList, "feed");
  }

  Future<dynamic> searchUserOrContent(String searchText, String type) async {
    List<dynamic> followingList;
    List<dynamic> postList = [];
    print("-----------------------------------------");

    if (type == "user") {
      searchUser = [];
      await _firestore
          .collection("users")
          .where("name", isEqualTo: searchText)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          User tempUser = User(
              name: doc["name"],
              surname: doc["surname"],
              username: doc["username"]);
          tempUser.id = doc.id;
          tempUser.image = doc["imageUrl"];

          searchUser.add(tempUser);
        });
      });
    } else {
      searchContent = [];
      await _firestore
          .collection("post")
          .where("description", isEqualTo: searchText)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          await _firestore
              .collection("users")
              .doc(doc["userId"])
              .get()
              .then((DocumentSnapshot documentSnapshotUser) {
            User tempUser = User(
                name: documentSnapshotUser["name"],
                surname: documentSnapshotUser["surname"],
                username: documentSnapshotUser["username"]);
            tempUser.id = documentSnapshotUser.id;
            tempUser.image = documentSnapshotUser["imageUrl"];

            Post tempPost = Post(
                description: doc["description"],
                image: doc["imageUrl"],
                sender: tempUser);
            tempPost.id = doc.id;
            tempPost.likedUsers = doc["likedUsers"];
            tempPost.dislikedUsers = doc["dislikedUsers"];

            searchContent.add(tempPost);
          });


        });
      });
    }

    await getAllUserPost(postList, "feed");
  }
}
