import 'package:cs310_app/objects/Post.dart';
import 'package:cs310_app/utils/grid_view.dart';
import 'package:flutter/cupertino.dart';

class SearchPost extends StatefulWidget {
  @override
  _SearchPostState createState() => _SearchPostState();
}

class _SearchPostState extends State<SearchPost> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: GridView.builder(
              itemCount: searchTopic.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) => PostCard(
                post: searchTopic[index],

              )),
        ),




      ],
    );
  }
}
