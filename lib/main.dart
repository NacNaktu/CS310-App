import 'package:cs310_app/firebase/analytics_service.dart';
import 'package:cs310_app/firebase/authentication_service.dart';
import 'package:cs310_app/routes/feed.dart';
import 'package:cs310_app/routes/login.dart';
import 'package:cs310_app/routes/notification.dart';
import 'package:cs310_app/routes/profile.dart';
import 'package:cs310_app/routes/profile_settings.dart';
import 'package:cs310_app/routes/search.dart';
import 'package:cs310_app/routes/signup.dart';
import 'package:cs310_app/routes/walkthrough.dart';
import 'package:cs310_app/routes/welcome.dart';
import 'package:cs310_app/utils/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        navigatorObservers: [locator<AnalyticsService>().getAnalyticsObserver()],



        home: AuthenticationWrapper(),

        routes: {
          '/walkthrough': (context) => WalkThrough(),
          '/welcome': (context) => Welcome(),
          '/login': (context) => Login(),
          '/signup': (context) => SignUp(),
          '/search': (context) => Search(),
          '/notification' : (context) => Not(),
          '/profile' : (context) => Profile(user: LoggedUser),
          '/feed' : (context) => Feed(),
          '/psettings' : (context) => ProfileSettings(),

        },
      ),
    );
  }
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();

  runApp(MyApp());

}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return Feed();
    }else{
      return WalkThrough();
    }

  }
}

