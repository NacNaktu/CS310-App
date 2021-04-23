import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/models/post_card.dart';
import 'package:flutter/material.dart';
class Feed extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Feed Page"),
            centerTitle: true,
          ),
          body:Column(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Divider(),


              BottomBar(),

            ],
          ),
        );
  }
}