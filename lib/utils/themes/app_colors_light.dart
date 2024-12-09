import 'package:flutter/material.dart';
class AppColorsLight{
AppColorsLight._();

//app basic colors
  static const kPrimaryColor = Color(0xFF031788);
  static const kSecondaryColor =Color(0xFFFFE24B);
  static const accent =Color(0xffb0c7ff);


// Gradient Colors

static const Gradient linerGradient = LinearGradient(
 begin:Alignment(0.0,0.0),
 end: Alignment(0.707, -0.707),
colors: [
Color(0xffff9a9e),
Color(0xfffad0c4),
Color(0xfffad0c4),

]
); // LinearGradient


//text colors
  static const kTextBlackColor =Color(0xFF000000);
  static const kTextWhiteColor = Color(0xFFFFFFFF);
  static const kTextyellowColor = Colors.amber;

//background colors
  static const kLight =Color(0xFFF6F6F6) ;
  static const kDark = Color(0xFF272727);
  static const kPrimaryBackground = Color(0xFFF3F5FF);


//button colors
  static const  kButtonPrimary = Color(0xFF031788);
  static const  kButtonSecondary = Color(0xFF6C757D);
  static const  kButtonDisabled= Color(0xFFC4C4C4);


//Border colors
static const  kBorderPrimary = Color(0xFF031788);
static const  kBorderSecondary = Color(0xFF6C757D);


//Error and  validation colors
  static const kErrorColor = Color(0xFFD32F2F);
  static const kSuccessColor = Color(0xFF388E3C);
  static const kWarningColor = Color(0xFFF57C00);
  static const kInfoColor = Color(0xFF1976D2);

// Neutral Shades

static const Color black = Color(0xFF232323);
static const Color darkerGrey = Color (0xFF4F4F4F);
static const Color darkGrey = Color(0xFF939393);
static const Color grey = Color (0xFFE0E0E0);
static const Color softGrey = Color (0xFFF4F4F4);
static const Color lightGrey = Color (0xFFF9F9F9);
static const Color white = Color(0xFFFFFFFF);



  static const kContainerColor =Color(0xFF777777);
  static const kOtherColor = Color(0xFFEDE9E9);

}