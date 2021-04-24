import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/objects/Post.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/grid_view.dart';
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
      bottomNavigationBar: BottomBar(),
      body:Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: GridView.builder(
                  itemCount: feedPost.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => PostCard(
                    post: feedPost[index],

                  )),
            ),
          ),
        ],
      ),

    );
  }
}