import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/objects/Post.dart';
import 'package:cs310_app/utils/classes.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/grid_view.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final User user;

  const Profile({Key key, this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  Widget build(BuildContext context) {
    double add;

    add = widget.user.info != null ? 50 : 0;
    return Scaffold(
      bottomNavigationBar: BottomBar(index: 2),
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: appBarStyle,
        ),
        centerTitle: true,
        backwardsCompatibility: false,
        elevation: 0.0,
        backgroundColor: AppColors.appBarColour,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backwardsCompatibility: false,
            brightness: Brightness.dark,
            elevation: 0.0,
            backgroundColor: AppColors.background,

            floating: true,
            collapsedHeight: 208 + add,

            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(8.0),
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
                            Icon(
                              Icons.account_circle,
                              size: 100.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.user.name + " " + widget.user.surname,
                                  style: underlinedStyle,
                                ),
                                Text(
                                  widget.user.username,
                                  style: underlinedStyle,
                                )
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          splashRadius: 20,
                          icon: Icon(
                            Icons.settings,
                            size: 20.0,

                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              "/psettings",
                            );
                          },
                        ),


                      ],
                    ),

                    Container(
                      height: widget.user.info != null? 50:0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.user.info != null ? widget.user.info : "",
                          style: bioTextStyle,
                        ),
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
                                      //TODO connect this to Topics
                                    },
                                    child: Text("Topics")),
                              )),
                          Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: OutlinedButton(
                                    style: profilePageButtonStyle,
                                    onPressed: () {
                                      //TODO connect this to connections
                                    },
                                    child: Text("Connections")),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  height: 500,
                  child: PostCard(
                    post: widget.user.shared[index],
                  ),
                );
              },
              childCount: widget.user.shared.length,
            ),
          ),
        ],
      ),
    );
  }
}
