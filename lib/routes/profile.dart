import 'package:cs310_app/models/bottomBar.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String mail, pass, pass2, name, userName;
  bool _isRecording = true;

  var routes = {
    0 : '/welcome',
    1 : '/login',
  };

  void onTap (int index)  {
    Navigator.pushNamed(context, routes[index]);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
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

                  Icon(
                    Icons.settings,
                    size: 40.0,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: OutlinedButton(style:profilePageButtonStyle, onPressed: null, child: Text("Info"))),
                  Expanded(child: OutlinedButton(style:profilePageButtonStyle, onPressed: null, child: Text("Topics"))),
                  Expanded(child: OutlinedButton(style:profilePageButtonStyle, onPressed: null, child: Text("Connections"))),

                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(32,32,32,16),
              width: 320.0,
              height: 200.0,
              child: Container(
                  child: Text("deneme123"),
                  decoration: new BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black),
                    shape:
                    _isRecording ? BoxShape.rectangle : BoxShape.circle,
                    borderRadius: _isRecording
                        ? BorderRadius.all(Radius.circular(8.0))
                        : null,
                  )
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(32,16,32,16),
              width: 320.0,
              height: 200.0,
              child: Container(
                  child: Text("deneme123"),
                  decoration: new BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.black),
                    shape:
                    _isRecording ? BoxShape.rectangle : BoxShape.circle,
                    borderRadius: _isRecording
                        ? BorderRadius.all(Radius.circular(8.0))
                        : null,
                  )
              ),
            ),
            /*   Container(
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.home),
                    iconSize: 40.0,
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    iconSize: 40.0,
                  ),
                  IconButton(
                    icon: const Icon(Icons.account_circle),
                    iconSize: 40.0,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_box),
                    iconSize: 40.0,
                  ),


                ],
              ),
            )  */
            BottomBar(),
          ],

        ),

      ),

    );
  }
}
