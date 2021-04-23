

import 'package:cs310_app/utils/classes.dart';
import 'package:flutter/material.dart';


class NotCard extends StatelessWidget {
  final Notif notif;
  final Function delete;
  NotCard({this.notif, this.delete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(0, 4.0, 0, 4.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              notif.note,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  notif.date,
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 15.0,
                    color: Colors.green, // change the color
                  ),
                  onPressed: delete,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}