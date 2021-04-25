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

List<Notif> nots = [
  Notif(note: 'Elon Musk liked your post', date: '8 May'),
  Notif(note: 'Rihanna followed you', date: '7 May'),
  Notif(note: 'Dua Lipa followed you', date: '7 May'),
  Notif(note: 'Dua Lipa liked your post', date: '7 May'),
  Notif(note: 'Keanu Reeves followed you', date: '6 May'),
  Notif(note: 'Jared Leto followed you', date: '6 May'),
  Notif(note: 'Johnny Depp liked your post', date: '6 May'),
  Notif(note: 'Kylie Jenner commented your post', date: '5 May'),

];

