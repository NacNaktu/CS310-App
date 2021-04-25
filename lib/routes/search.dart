import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/models/search_loc.dart';
import 'package:cs310_app/models/search_post.dart';
import 'package:cs310_app/models/search_user.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String search;


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: BottomBar(),
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.appBarColour,
          title: Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (text) {
                  setState(() {
                    search = text;
                  });
                },
                decoration: InputDecoration(
                  icon: IconButton(
                    splashRadius: 24,
                    iconSize: 24,
                    icon: Icon(Icons.search), onPressed: () {  },
                  ),

                ),
              ),
            ),

          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [

              Tab(
                text: "Users",
              ),
              Tab(
                text: "Topics",
              ),
              Tab(
                text: "Locations",
              ),
            ],

          ),
        ),
        body: TabBarView(
          children: [
            SearchUser(),
            SearchPost(),
            SearchLoc(),
          ],
        ),
      ),
    );
  }
}

