import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cs310_app/firebase/authentication_service.dart';
import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/classes.dart' as classes;
import 'package:cs310_app/utils/styles.dart';
import 'package:cs310_app/utils/variables.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String mail, pass;
  String name, surname, username, info;
  bool private = false;
  String userId;

  final _formKey = GlobalKey<FormState>();

  void getUser() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        LoggedUser = classes.User(
            name: documentSnapshot["name"],
            surname: documentSnapshot["surname"],
            username: documentSnapshot["username"]);


        LoggedUser.image = documentSnapshot["imageUrl"];
        LoggedUser.id = userId;
        LoggedUser.info = documentSnapshot["bio"];
        LoggedUser.connections = documentSnapshot["connections"];
        LoggedUser.followers = documentSnapshot["followers"];




      }
    });
  }

  Future<void> showAlertDialog(String title, String message) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
      } else {
        userId = user.uid;
        getUser();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'LOGIN',
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
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.alternate_email,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          style: hintTextStyle,
                          decoration: InputDecoration(
                            fillColor: AppColors.secondary,
                            filled: false,
                            hintText: 'E-mail',
                            hintStyle: hintTextStyle,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          style: hintTextStyle,
                          decoration: InputDecoration(
                            fillColor: AppColors.secondary,
                            filled: false,
                            hintText: 'Password',
                            hintStyle: hintTextStyle,
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
                            pass = value;
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
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                await context
                                    .read<AuthenticationService>()
                                    .signIn(
                                      email: mail,
                                      password: pass,
                                    );
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AuthenticationWrapper()),
                                );


                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'Login',
                                style: buttonTextStyle,
                              ),
                            ),
                            style: buttonStyle),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
              child: Text('Forgot My Password', style: lightTextStyle),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/welcome");
              },
            ),
            Text(
              "   |   ",
              style: lightTextStyle,
            ),
            InkWell(
              child: Text('Sign Up', style: lightTextStyle),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/signup");
                }
            ),
          ])
        ],
      ),
    );
  }
}
