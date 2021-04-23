import 'package:flutter/material.dart';

class ProfileSettings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                // ignore: deprecated_member_use
                RaisedButton.icon(
                  onPressed: () {
                    print('Change Username');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text('Button With Left Icon',
                    style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.android, color: Colors.white,),
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  color: Colors.green,),


                RaisedButton.icon(
                  onPressed: () {
                    print('Button Clicked.');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text('Change Password',
                    style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.camera_alt, color: Colors.white,),
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  color: Colors.lightBlue,),

                RaisedButton.icon(
                  onPressed: () {
                    print('Change Username');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text('Account Visibility',
                    style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.android, color: Colors.white,),
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  color: Colors.green,),

                RaisedButton.icon(
                  onPressed: () {
                    print('Button Clicked.');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text('Change Password',
                    style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.camera_alt, color: Colors.white,),
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  color: Colors.lightBlue,),

                RaisedButton.icon(
                  onPressed: () {
                    print('Change Username');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text('Deactivate my Account',
                    style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.android, color: Colors.white,),
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  color: Colors.green,),

                RaisedButton.icon(
                  onPressed: () {
                    print('Button Clicked.');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text('Delete my Account',
                    style: TextStyle(color: Colors.white),),
                  icon: Icon(Icons.camera_alt, color: Colors.white,),
                  textColor: Colors.white,
                  splashColor: Colors.red,
                  color: Colors.lightBlue,),


                Container(
                    width: 210,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0))),
                        onPressed: () {
                          print('Button Clicked.');
                        },
                        textColor: Colors.white,
                        color: Colors.pink,
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                Container(
                                  color: Colors.pink,
                                  padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                                  child: Text('Button With Right Icon',
                                    style: TextStyle(color: Colors.white),),
                                ),

                                Padding(
                                  padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                                  child: Icon(
                                    Icons.backup,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ))))
              ],)
        )
    );
  }
}