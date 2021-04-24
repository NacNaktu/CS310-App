import 'dart:html';
import 'dart:js';
import 'package:flutter/material.dart';
import 'package:cs310projectpart/main.dart';


class SearchResultProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            CircleAvatar(),
            UserCard(name:'', surname: ''),
            UserCard(username: ''),
        ],
      ),
    );
  }
}

class SearchResultPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              ListTile(
                leading: CircleAvatar(),
                title: Text('name surname'),    //UserCard.name surname alması gerek 15. line da işe yaramadı burayı böyle yaptım
              )
            ],
          ),
          Expanded(child: AssetImage())
        ],
      ),
    );
  }
}