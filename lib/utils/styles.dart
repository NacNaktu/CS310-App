import 'package:cs310_app/utils/color.dart';
import 'package:flutter/material.dart';



final lightTextStyle = TextStyle(
  color: AppColors.textColor,
  fontSize: 14.0,
  letterSpacing: 0.7,
);

final appBarStyle = TextStyle(
  color: Colors.white,
  fontSize: 24.0,
  fontWeight: FontWeight.w600,
  letterSpacing: -0.7,
);

final mainTextStyle = TextStyle(
  color: AppColors.textColor,
  fontSize: 20.0,
  fontWeight: FontWeight.w600,
  letterSpacing: -0.7,
);

final secondaryTextStyle = TextStyle(
  color:  AppColors.textColor,
  fontSize: 18.0,
  fontWeight: FontWeight.w500,
  letterSpacing: -0.7,
);

final buttonStyle = OutlinedButton.styleFrom(
  backgroundColor: AppColors.primary,
);

final buttonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
  letterSpacing: -0.7,
);

final hintTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 15.0,
  letterSpacing: 1.1,
);


final labelStyle = TextStyle(
  color: AppColors.textColor,
  fontSize: 13.0,
);

final errorStyle = TextStyle(
  color: AppColors.errorColor,
  fontSize: 12.0,
  fontWeight: FontWeight.bold,
);

final underlinedStyle = TextStyle(
    color: AppColors.textColor,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 1.7,
    decoration: TextDecoration.underline,
    letterSpacing: 1.5

);

final ButtonStyle profilePageButtonStyle = TextButton.styleFrom(
  primary: Colors.black87,
  minimumSize: Size(100, 50),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);


