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
    Notif(note: 'ABC liked your post', date: '8 May'),
    Notif(note: 'You have new followers!', date: '7 May'),
    Notif(note: 'X followed you', date: '7 May'),
    Notif(note: 'Y followed you', date: '7 May'),
    Notif(note: 'Y liked your post', date: '7 May'),
  ];

  void deleteNot(Notif notif) {
    setState(() {
      nots.remove(notif);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notifications'),
          centerTitle: true,
          backgroundColor: AppColors.appBarColour,
        ),
        body: Column(
          children: [
            GridView.builder(
                itemCount: nots.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => NotCard(
                  //not: nots[index],
                  ),
                ),
          ]
        ),
    );
  }
}