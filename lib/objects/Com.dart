
import 'package:cs310_app/firebase/firestoreService.dart';
import 'package:cs310_app/routes/profile.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComCard extends StatefulWidget {
  final Comment comment;

  const ComCard({
    Key key,
    this.comment,
  }) : super(key: key);

  @override
  _ComCardState createState() => _ComCardState();
}

class _ComCardState extends State<ComCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profile(user: widget.comment.user)),
        );
      },
      child: Card(
        color: AppColors.cardColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 70,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(im),
                  radius: 50,
                ),
                title: Text(widget.comment.user.id),
                subtitle: Text(widget.comment.comment),

              ),

            ],
          ),
        ),
      ),
    );
  }
}
