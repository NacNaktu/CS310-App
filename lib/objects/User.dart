import 'package:cs310_app/utils/classes.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 80,
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(),
              title: Text(user.name + " " + user.surname),
              subtitle: Text(user.username),
            ),
          ],
        ),
      ),
    );
  }
}
