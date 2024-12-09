// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
class TColors{
TColors._();

//app basic colors
  static const PrimaryColor = Color.fromARGB(255, 80, 105, 247);
  static const PrimaryColor2 = Color.fromARGB(255, 27, 150, 119);
  static const SecondaryColor =Color(0xFFFFE24B);
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
  static const TextBlackColor =Color(0xFF000000);
  static const TextWhiteColor = Color(0xFFFFFFFF);
  static const TextyellowColor = Colors.amber;

//background colors
  static const Light =Color(0xFFF6F6F6) ;
  static const Dark = Color(0xFF272727);
  static const PrimaryBackground = Color(0xFFF3F5FF);


//button colors
  static const  ButtonPrimary = Color(0xFF031788);
  static const  ButtonSecondary = Color(0xFF6C757D);
  static const  ButtonDisabled= Color(0xFFC4C4C4);


//Border colors
static const  BorderPrimary = Color(0xFFD9D9D9);
static const  BorderSecondary = Color(0xFFE6E6E6);


//Error and  validation colors
  static const ErrorColor = Color(0xFFD32F2F);
  static const SuccessColor = Color(0xFF388E3C);
  static const WarningColor = Color(0xFFF57C00);
  static const InfoColor = Color(0xFF1976D2);

// Neutral Shades

static const Color black = Color(0xFF232323);
static const Color darkerGrey = Color (0xFF4F4F4F);
static const Color darkGrey = Color(0xFF939393);
static const Color grey = Color (0xFFE0E0E0);
static const Color softGrey = Color (0xFFF4F4F4);
static const Color lightGrey = Color (0xFFF9F9F9);
static const Color white = Color(0xFFFFFFFF);



  static const ContainerColor =Color(0xFF777777);
  static const OtherColor = Color(0xFFEDE9E9);

}