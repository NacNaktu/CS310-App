import 'package:cs310_app/routes/profile.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  final User user;

  const UserCard({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profile(user: widget.user)),
        );
      },
      child: Card(
        child: Container(
          width:  MediaQuery. of(context). size. width,
          height: 70,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(),
                title: Text(widget.user.name + " " + widget.user.surname),
                subtitle: Text(widget.user.username),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
