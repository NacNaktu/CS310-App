// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

class Notif {
  String note;
  String date;

  Notif({this.note, this.date});
}

class Comment {
  int likes;
  String comment;
  DateInputElement date;

  Comment({this.likes, this.comment, this.date});
}


class Post {
  User sender;
  int likes;
  int dislike;
  int commentNum;
  String image;
  String comments;
  DateInputElement date;
  List<Comment> commentList;

  Post({this.likes, this.comments, this.date});
}

class User{
  String name, surname, username;
  int followers, following, posts;
  List<Post> postList;

  User({this.name, this.surname, this.username, this.followers, this.following, this.posts});
}


class NotifCard {
  String message, follow, like;

  NotifCard({this.message, this.follow, this.like});
}

