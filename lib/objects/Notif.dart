import 'package:cs310_app/routes/notification.dart';
import 'package:cs310_app/routes/profile.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/grid_view.dart';
import 'package:flutter/material.dart';

class NotCard extends StatefulWidget {
  final Notif notif;

  const NotCard({Key key, this.notif}) : super(key: key);

  @override
  _NotCardState createState() => _NotCardState();
}

class _NotCardState extends State<NotCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){
          //TODO delete the notification
          nots.remove(widget.notif);


        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Not()),
        );
      },
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Profile(user: widget.notif.sender)),
        );
      },
      child: Card(
        color: AppColors.cardColor,
        margin: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.notif.sender.name +
                    " " +
                    widget.notif.sender.surname +
                " " + widget.notif.note),

                Text(
                  widget.notif.date,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
