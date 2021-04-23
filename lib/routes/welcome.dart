import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:cs310_app/routes/signup.dart';
import 'package:cs310_app/routes/login.dart';




class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}


class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:NetworkImage("https://previews.123rf.com/images/aimage/aimage1505/aimage150500095/40260204-social-network-vector-background-friends-family-and-colleagues-communicating-via-social-networking-b.jpg"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.elliptical(200.0, 80.0)
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "CS310ster\n",
                        style: mainTextStyle,
                      ),
                      TextSpan(
                        text: "Networking on a course demand",
                        style: secondaryTextStyle,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Login();
                                },
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 25),
                              padding:
                              EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.textColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "START CONNECTING",
                                    style: Theme.of(context).textTheme.button.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return SignUp();
                                },
                              ));
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 25),
                              padding:
                              EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: AppColors.textColor,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "SIGN UP NOW",
                                    style: Theme.of(context).textTheme.button.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
