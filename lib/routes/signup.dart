import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_app/firebase/authentication_service.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/dimension.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String mail, pass, pass2, name, userName;
  String imageUrl = "";
  final _formKey = GlobalKey<FormState>();

  void setImageUrl(String tempUrl){
    this.imageUrl = tempUrl;
  }


  Future<void> signUpToFirebaseAuth() async {
    await context.read<AuthenticationService>().signUp(
      email: mail,
      password: pass,
    );

  }

  Future<void> signUpUser() async {
    FirebaseFirestore.instance
        .collection('misc')
        .doc("usernameList")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        if(documentSnapshot["list"].contains(userName)){
          print("username exists");
        }
        else{
          signUpToFirebaseAuth();

        }
      }
    });


    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        DocumentReference users =
        FirebaseFirestore.instance.collection('users').doc(user.uid);
        users.set({
          'name': name,
          'surname': "surname",
          'username': userName,
          "follower": "0",
          "following": "0",
          "posts": "0",
          "image": "string",
          "postList": "",
          "email": mail,
          "imageUrl":imageUrl,
          "visible":true,
          "active":true
        });

        DocumentReference postList = FirebaseFirestore.instance.collection('postList').doc(user.uid);
        postList.set(
            {"postList":[]}
        );

        DocumentReference usernameList = FirebaseFirestore.instance.collection('misc').doc("usernameList");
        usernameList.update({
          "list":FieldValue.arrayUnion([userName])
        });
      }
    });


    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AuthenticationWrapper()),
    );
  }

  Future<void> showAlertDialog(String title, String message) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, //User must tap button
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'SIGN UP',
          style: appBarStyle,
        ),
        backgroundColor: AppColors.appBarColour,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(

                            hintText: 'E-mail',
                            labelStyle: labelStyle,
                            errorStyle: errorStyle,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your e-mail';
                            }
                            if (!EmailValidator.validate(value)) {
                              return 'The e-mail address is not valid';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            mail = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(

                            hintText: 'Name',
                            labelStyle: labelStyle,
                            errorStyle: errorStyle,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            name = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(

                            hintText: 'Username',
                            labelStyle: labelStyle,
                            errorStyle: errorStyle,
                          ),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your e-mail';
                            }
                            if (value.length < 4) {
                              return 'Username is too short';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            userName = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(

                            hintText: 'Password',
                            labelStyle: labelStyle,
                            errorStyle: errorStyle,
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            pass = value;
                          },
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(

                            hintText: 'Password (Repeat)',
                            labelStyle: labelStyle,
                            errorStyle: errorStyle,
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            pass2 = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();

                                if (pass != pass2) {
                                  showAlertDialog(
                                      "Error", 'Passwords must match');
                                } else {
                                  signUpUser();
                                }
                                //

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Signing up')));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Text(
                                'Sign Up',
                                style: buttonTextStyle,
                              ),
                            ),
                            style: buttonStyle),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              child: Text('Forgot My Password',
                                  style: lightTextStyle),
                              onTap: () =>
                                  Navigator.pushNamed(context, "/welcome")),
                          /*VerticalDivider(thickness: 5,
                width: 20,
                color: Colors.black,
              ),*/

                          Text(
                            "   |   ",
                            style: lightTextStyle,
                          ),
                          InkWell(
                            child: Text('Login', style: lightTextStyle),
                            onTap: () =>
                                Navigator.pushNamed(context, "/login"),
                          ),
                        ]),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
