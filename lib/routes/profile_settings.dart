import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_app/firebase/firestoreService.dart';
import 'package:cs310_app/utils/variables.dart';
import 'package:provider/provider.dart';
import 'package:cs310_app/firebase/authentication_service.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../main.dart';

class ProfileSettings extends StatefulWidget {
  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}



class _ProfileSettingsState extends State<ProfileSettings> {


  @protected
  @mustCallSuper
  void initState() {
    changeVisible();

  }

  bool _visible = false;

  String value;

  final _formKey = GlobalKey<FormState>();



  void changeVisible() async {
    final temp = await context.read<FirestoreServicee>().getVisible("seUiDJ9iPVhtf0b7f0D7qIzpZEc2");
    _visible = temp;
  }




  @override
  Widget build(BuildContext context)  {
    changeVisible();





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
                  onPressed: ()  {
                    _openPopup( "username" );


                  },
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
                  onPressed: ()  {
                    _openPopup("bio" );

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0))),
                  child: Text('Change Bio',
                    style: TextStyle(fontSize: 14,
                      color: Colors.black,
                      letterSpacing: 2.2,
                    ),
                  ),
                ),

                RaisedButton(
                  onPressed: ()  {
                    _openPopup("password");

                  },
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
                        //TODO id degistirilecek
                        value: _visible,
                        onChanged: (bool value) async {
                          //TODO id degisecek
                          print("change");
                          await context.read<FirestoreServicee>().changeVisible("seUiDJ9iPVhtf0b7f0D7qIzpZEc2",value);
                          setState(() {
                            _visible = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),


                RaisedButton(
                  onPressed: () async  {
                    //id degisecek
                    //TODO
                    await context.read<AuthenticationService>().signOut();
                    context.read<FirestoreServicee>().deactivateUser("seUiDJ9iPVhtf0b7f0D7qIzpZEc2");
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthenticationWrapper()),
                    );

                    },
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
                  onPressed: () async {
                    //id degisecek
                    //TODO
                    await context.read<AuthenticationService>().deleteAccount();
                    await context.read<FirestoreServicee>().deleteUser("6jQGXysgjqQsUGTZo0VfQmCCWCV2");
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthenticationWrapper()),
                    );

                  },
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

                RaisedButton(
                  onPressed: () async {
                    await context.read<AuthenticationService>().signOut();
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthenticationWrapper()),
                    );

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(10.0))),
                  child: Text('Sign Out',
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


  _openPopup(String name) {
    Alert(
        context: context,
        title: "Change" + name,
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: name,
                ),
                onSaved:  (String temp){  value = temp;} ,
              ),

            ],
          ),
        ),
        buttons: [
          DialogButton(
            onPressed: () async {
              await _formKey.currentState.save();
              name != "password" ?
                  //TODO user id olucak
              context.read<FirestoreServicee>().updateUserField("1glzDGoxoST1l1o1lr1orpCRDyg2",name,value)
                  :  context.read<AuthenticationService>().changePassword(value);



              Navigator.pop(context);
              Navigator.pushNamed(context, "/psettings");
            },
            child: Text(
              "Change",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ]).show();
  }
}