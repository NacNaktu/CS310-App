
import 'package:cs310_app/firebase/firestoreService.dart';
import 'package:cs310_app/firebase/post_service.dart';
import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/objects/Post.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:provider/provider.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:cs310_app/utils/variables.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

import 'package:rflutter_alert/rflutter_alert.dart';

import 'connections.dart';
import 'followers.dart';

class PrivateProfile extends StatefulWidget {
  final User user;

  const PrivateProfile({Key key, this.user}) : super(key: key);

  @override
  _PrivateProfileState createState() => _PrivateProfileState();
}

class _PrivateProfileState extends State<PrivateProfile> {
  String imageUrl = "";
  File image;
  FirestoreServicee _service;

  void setImageUrl(String tempUrl) {
    this.imageUrl = tempUrl;
  }

  Future<void> loadPosts() async {
    await context.read<PostService>().getAllUserPostsId(LoggedUser.id);
    await Future.delayed(Duration(milliseconds: 100000));
  }

  @protected
  @mustCallSuper
  // ignore: must_call_super
  void initState() {
    loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    loadPosts();

    double add;
    print(LoggedUser.id);

    add = widget.user.info != null ? 50 : 0;
    return Scaffold(
      bottomNavigationBar: BottomBar(index: 2),
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backwardsCompatibility: false,
            brightness: Brightness.dark,
            elevation: 0.0,
            backgroundColor: AppColors.appBarColour,
            floating: true,
            collapsedHeight: 218 + add,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(8, 30, 8, 8),
              centerTitle: false,
              title: Container(
                width: MediaQuery.of(context).size.width - 16,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CircleAvatar(
                              //TODO change to user image
                              backgroundImage: NetworkImage(widget.user.image),
                              radius: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    widget.user.name ,
                                    style: underlinedStyle,
                                  ),
                                  Text(
                                    widget.user.username,
                                    style: underlinedStyle,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          splashRadius: 20,
                          icon: Icon(
                            Icons.report,
                            size: 20.0,
                          ),
                          onPressed: () {
                            //TODO report in database
                          },
                        ),
                      ],
                    ),
                    Container(
                      height: widget.user.info != null ? 50 : 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.user.info != null ? widget.user.info : "",
                              style: bioTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: OutlinedButton(
                                    style: profilePageButtonStyle,
                                    onPressed: () {

                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Connections(user: widget.user)),);
                                    },
                                    child: Text("Following")),
                              )),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: OutlinedButton(
                                    style: profilePageButtonStyle,
                                    onPressed: () {

                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Followers(user: widget.user)),);
                                    },
                                    child: Text("Followers")),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
