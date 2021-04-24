import 'package:cs310_app/models/notification_card.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:flutter/material.dart';


class Not extends StatefulWidget {
  @override
  _NotState createState() => _NotState();
}

class _NotState extends State<Not> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
          centerTitle: true,
          backgroundColor: ,
        ),
        body: Column(
          children: nots.map((notif) => NotCard(notif: notif)).toList(),
        ));
  }
}
