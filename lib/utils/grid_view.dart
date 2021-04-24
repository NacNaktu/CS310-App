import 'package:cs310_app/objects/Post.dart';
import 'package:cs310_app/objects/User.dart';

import 'classes.dart';

List<User> searchUser = [
  User(
    name: "Can Utkan",
    surname: "KARAHAN",
    username: "@ukarahan"
  ),

  User(
      name: "Yunus",
      surname: "YASAR",
      username: "@yunusy"
  ),



];

List<Post> searchPost = [


];

List<Post> feedPost = [
  Post(
    sender: User(
        name: "Yunus",
        surname: "YASAR",
        username: "@yunusy"
    ),

    image: "https://im0-tub-tr.yandex.net/i?id=f6f5e2ee81f7d4c4eecd02d738d31bad&n=13",
  ),

  Post(
    sender: User(
        name: "Can Utkan",
        surname: "KARAHAN",
        username: "@ukarahan"
    ),

    image: "https://im0-tub-tr.yandex.net/i?id=f6f5e2ee81f7d4c4eecd02d738d31bad&n=13",
  ),

];

