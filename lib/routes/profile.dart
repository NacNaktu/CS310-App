import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/objects/Post.dart';
import 'package:cs310_app/routes/profile_settings.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/grid_view.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  bool _isRecording = true;



  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(index: 2),

      backgroundColor: AppColors.background,
      appBar: AppBar(
        backwardsCompatibility: false,

        title: Text(
          'Profile Page',
          style: appBarStyle,
        ),
        backgroundColor: AppColors.appBarColour,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            Container(
              height: 140,
              padding: EdgeInsets.all(16),
              child: Row(
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20,0,0,0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Yunus Yasar",style: underlinedStyle,
                            ),


                            Text("Yunus_Yasar111",style: underlinedStyle,)
                          ],
                        ),
                      ),

                    ],
                  ),

                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      size: 40.0,
                    ), onPressed: () { Navigator.pushNamed(context, "/psettings",); },
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: OutlinedButton(style:profilePageButtonStyle, onPressed: null, child: Text("Info"))),
                  Expanded(child: OutlinedButton(style:profilePageButtonStyle, onPressed: null, child: Text("Topics"))),
                  Expanded(child: OutlinedButton(style:profilePageButtonStyle, onPressed: null, child: Text("Connections"))),

                ],
              ),
            ),

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

      ),

    );
  }
}
