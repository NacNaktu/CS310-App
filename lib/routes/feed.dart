import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/objects/Post.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/grid_view.dart';
import 'package:flutter/material.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backwardsCompatibility: false,
        backgroundColor: AppColors.appBarColour,
        title: Text("Feed"),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomBar(index:0),
      body:Column(
        children: [
          Expanded(
            flex: 1,
            child: GridView.builder(
                itemCount: feedPost.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => PostCard(
                  post: feedPost[index],

                )),
          ),
        ],
      ),

    );
  }
}