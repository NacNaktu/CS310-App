import 'package:cs310_app/utils/color.dart';
import 'package:cs310_app/utils/dimension.dart';
import 'package:cs310_app/utils/styles.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String mail, pass;

  final _formKey = GlobalKey<FormState>();

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
    return Scaffold(
      backgroundColor: AppColors.background,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(

              height: MediaQuery. of(context). size. height * 2/3,
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0,top: 80.0, right: 16.0, bottom: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
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
                    children: <Widget> [
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
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Logging in')));
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
          Padding(
            padding: const EdgeInsets.only(left: 16.0,top: 0.0, right: 16.0, bottom: 250.0),
            child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                  child: Text('Forgot My Password', style: lightTextStyle),
                  onTap: () => Navigator.pushNamed(context, "/welcome")),

              Text(
                "   |   ",
                style: lightTextStyle,
              ),
              InkWell(
                child: Text('Sign Up', style: lightTextStyle),
                onTap: () => Navigator.pushNamed(context, "/signup"),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
