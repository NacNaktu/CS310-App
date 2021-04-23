import 'package:cs310_app/routes/feed.dart';
import 'package:cs310_app/routes/login.dart';
import 'package:cs310_app/routes/notification.dart';
import 'package:cs310_app/routes/profile.dart';
import 'package:cs310_app/routes/profile_settings.dart';
import 'package:cs310_app/routes/search.dart';
import 'package:cs310_app/routes/signup.dart';
import 'package:cs310_app/routes/walkthrough.dart';
import 'package:cs310_app/routes/welcome.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => WalkThrough(),
    '/welcome': (context) => Welcome(),
    '/login': (context) => Login(),
    '/signup': (context) => SignUp(),
    '/search': (context) => Search(),
    '/not' : (context) => Not(),
    '/profile' : (context) => Profile(),
    '/feed' : (context) => Feed(),
    '/psettings' : (context) => ProfileSettings(),

  },
));

