import 'package:cs310_app/objects/Post.dart';
import 'package:cs310_app/objects/User.dart';

import 'classes.dart';

//Feed Page

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

//Search Page

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

List<Post> searchContent = [
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

List<Post> searchTopic = [
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

List<Post> searchLoc = [
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

//Notifications Page

List<Notif> nots = [
  Notif(note: ' liked your post', date: '8 May'),
  Notif(note: ' followed you', date: '7 May'),
  Notif(note: ' followed you', date: '7 May'),
  Notif(note: ' liked your post', date: '7 May'),
  Notif(note: ' followed you', date: '6 May'),
  Notif(note: ' followed you', date: '6 May'),
  Notif(note: ' liked your post', date: '6 May'),
  Notif(note: ' commented your post', date: '5 May'),

];

//Profile Page

List<Post> userPosts = [

];

List<User> userConnections = [

];

List<String> userTopics = [

];

