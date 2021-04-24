import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/models/post_card.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBarColour,
        title: Text("Feed Page"),
        centerTitle: true,
      ),
      body:ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => CardItem(),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}