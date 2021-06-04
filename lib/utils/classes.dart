class User{
  String name, surname, username;
  String image;
  bool active = true;
  bool private = false;

  List<String> topics = [];
  List<String> locations = [];
  List<User> connections = [];

  User({this.name, this.surname, this.username,});
}

class Post {
  User sender;
  int likes = 0;
  int dislike = 0;
  int commentNum = 0;
  String image = " ";
  //DateInputElement date;
  List<Comment> commentList = [];
  List<String> likedUsers = [];


  Post({this.sender, this.image,});
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

  Notif({this.note, this.date});
}









