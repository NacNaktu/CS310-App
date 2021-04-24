import 'dart:html';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:cs310projectpart/main.dart';


class UserCard extends StatelessWidget {

  const UserCard({
      Key key,
      this.name,
      this.surname,
      this.username,
      this.followers,
      this.following,
      this.posts,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              ListTile(
                leading: CircleAvatar(),
                title: UserCard(
                  name: 'Name',
                  surname: 'Surname',
                  username: 'Username',
              )
            ],
          ),
          Row(
            children: [
              UserCard(followers: 12, following: 23, posts: 5,),
            ],
          ),
        ],
      )
    );
  }
}
