

import 'package:cs310_app/firebase/firestoreService.dart';
import 'package:cs310_app/firebase/post_service.dart';
import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/models/search_content.dart';
import 'package:cs310_app/models/search_user.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}




class _SearchState extends State<Search> {
  String search;
  String type;

  Future<void> loadUsers() async {
    await context.read<FirestoreServicee>().getAllUser();
    await Future.delayed(Duration(milliseconds: 200000));
  }

  @protected
  @mustCallSuper
  // ignore: must_call_super
  void initState()  {
    loadUsers();
  }


  @override
  Widget build(BuildContext context) {
    loadUsers();



    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: BottomBar(index: 1),
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backwardsCompatibility: false,
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
                onTap: () async{

                  await context.read<PostService>().searchUserOrContent(search,type);

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
            onTap: (value){

              final tempDict = {
                0:"user",
                1:"content"
              };
              type = tempDict[value];
              print(type);
            },
            indicatorColor: Colors.white,
            tabs: [

              Tab(
                text: "Users",
              ),
              Tab(
                text: "Content",

              ),
            ],

          ),
        ),
        body: TabBarView(
          children: [
            SearchUser(),
            SearchCont(),
          ],
        ),
      ),
    );
  }
}

