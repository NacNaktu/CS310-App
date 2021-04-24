

import 'package:cs310_app/utils/classes.dart';
import 'package:flutter/material.dart';


class NotCard extends StatelessWidget {
  final Notif notif;
  NotCard({this.notif});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              notif.note,
            ),
            SizedBox(height: 6.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  notif.date,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
