import 'package:cs310_app/utils/variables.dart';

class User{
  String name, surname, username, info, id;
  String image;
  bool active = true;
  bool private = false;

  List<Post> bookmarked = [];
  List<Post> shared = [];
  List<String> locations = [];
  List<dynamic> connections = [];

  User({this.name, this.surname, this.username,});
}

class Post {
  User sender;
  String description;
  String image = " ";
  String id;
  //DateInputElement date;
  List<dynamic> commentList = [];
  List<dynamic> likedUsers = [];
  List<dynamic> dislikedUsers = [];


  Post({this.sender, this.image, this.description});
}
class Comment {
  int likes;
  int dislike;
  String comment;
  //DateInputElement date;

  Comment({this.comment,});
}

class Notif {
  String note;
  String date;
  User user;
  bool sendToUser = true;
  User sender = LoggedUser;

  Notif({this.note, this.date});
}









