

class Post {
  User sender;
  int likes = 0;
  int dislike = 0;
  int commentNum = 0;
  String image = " ";
  //DateInputElement date;
  List<Comment> commentList = [];

  Post({this.sender, this.image,});
}

class User{
  String name, surname, username;
  int followers, following, posts = 0;
  String image;

  List<Post> postList = [];

  User({this.name, this.surname, this.username,});
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

  Notif({this.note, this.date});
}







class NotifCard {
  String message, follow, like;

  NotifCard({this.message, this.follow, this.like});
}

