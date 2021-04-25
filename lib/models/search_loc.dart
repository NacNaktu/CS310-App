import 'package:cs310_app/objects/Post.dart';
import 'package:cs310_app/utils/grid_view.dart';
import 'package:flutter/cupertino.dart';

class SearchLoc extends StatefulWidget {
  @override
  _SearchLocState createState() => _SearchLocState();
}

class _SearchLocState extends State<SearchLoc> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: GridView.builder(
                itemCount: searchLoc.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => PostCard(
                  post: searchLoc[index],

                )),
          ),
        ),




      ],
    );
  }
}
