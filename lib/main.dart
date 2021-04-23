import 'package:cs310_app/routes/login.dart';
import 'package:cs310_app/routes/search.dart';
import 'package:cs310_app/routes/signup.dart';
import 'package:cs310_app/routes/walkthrough.dart';
import 'package:cs310_app/routes/welcome.dart';
import 'package:flutter/material.dart';

bool opened = false;

void walk(){
  if (!opened){
    WalkThrough();
    opened = true;
  }
}

void main() => runApp(MaterialApp(
  //initialRoute: '/',
  routes: {
    '/': (context) => WalkThrough(),
    '/welcome': (context) => Welcome(),
    '/login': (context) => Login(),
    '/signup': (context) => SignUp(),
    '/search': (context) => Search(),

  },
));

