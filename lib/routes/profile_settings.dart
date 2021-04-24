
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.appBarColour,
          title: Text("EDIT PROFILE"),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            color: Colors.transparent,
            height: 400,
            padding: EdgeInsets.all(20),


            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: <Widget>[

                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Text("Change Username",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      letterSpacing: 2.2,
                    ),
                  ),


                ),
                RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0))),
                  child: Text('Change Password',
                    style: TextStyle(fontSize: 14,
                      color: Colors.black,
                      letterSpacing: 2.2,
                    ),
                  ),
                ),

                MergeSemantics(
                  child: Container(
                    width: 200,
                    child: ListTile(
                      title: Text('Account Visibility',
                        style: mainTextStyle,),

                      trailing: CupertinoSwitch(
                        value: _visible,
                        onChanged: (bool value) {
                          setState(() {
                            _visible = value;
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          _visible = !_visible;
                        });
                      },
                    ),
                  ),
                ),


                RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0))),
                  child: Text('Deactive myAccount',
                    style: TextStyle(fontSize: 14,
                      color: Colors.black,
                      letterSpacing: 2.2,
                    ),
                  ),

                ),

                RaisedButton(
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0))),
                  child: Text('Delete myAccount',
                    style: TextStyle(fontSize: 14,
                      color: Colors.black,
                      letterSpacing: 2.2,
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
    );
  }
}