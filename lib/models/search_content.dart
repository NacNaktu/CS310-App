import 'package:cs310_app/objects/Post.dart';
import 'package:cs310_app/utils/grid_view.dart';
import 'package:flutter/cupertino.dart';

class SearchCont extends StatefulWidget {
  @override
  _SearchContState createState() => _SearchContState();
}

class _SearchContState extends State<SearchCont> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: GridView.builder(
              itemCount: searchContent.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) => PostCard(
                post: searchContent[index],

              )),
        ),




      ],
    );
  }
}
