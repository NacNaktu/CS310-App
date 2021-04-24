import 'dart:html';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:cs310projectpart/main.dart';

class PostCard extends StatelessWidget {

  const PostCard({
    Key key,
    this.likes,
    this.comments,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      AssetImage(asset),),
                    title: Text('name surname'),
                    subtitle: Text("@username"),
                  ),
                ],
              ),
                Container(),
              Row(
                children: [
                  IconButton( icon: Icons.thumb_up, onPressed: ,),
                  Text(PostCard.likes),

                  IconButton( icon: Icons.comment, onPressed: ,),
                  Text(PostCard.comments),

                  Icon(icon: Icons.location_on),
                  Text('Location'),
                ],
              ),
            ],
          ),
        )
    );
  }
}