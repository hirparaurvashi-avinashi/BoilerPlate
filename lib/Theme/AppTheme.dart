import 'package:flutter/material.dart';

class DesignCourseAppTheme {
  static Color appThemeColor;

  DesignCourseAppTheme(Color themeColor){
    appThemeColor = themeColor;
  }

  DesignCourseAppTheme._();

//  static const Color themeColor = Color(0xFFE75300);

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);

  static TextTheme textTheme = TextTheme(
    display1: display1,
    display2: display2,
    headline: headline,
    title: title,
    subtitle: subtitle,
    body1: body1,
    caption: caption,
  );

  static TextStyle display1 = TextStyle( // h4 -> display1
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.bold,
    fontSize: 36,
    color: darkerText,
  );

  static TextStyle display2 = TextStyle( // h4 -> display1
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.bold,
    fontSize: 18,
    height: 1.0,
    color: appThemeColor,
  );

  static TextStyle styleWithTextTheme = TextStyle( // h4 -> display1
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w400,
    fontSize: 15,
    color: appThemeColor,
  );

  static TextStyle headline = TextStyle( // h5 -> headline
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: appThemeColor,
  );

  static TextStyle title = TextStyle( // h6 -> title
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.bold,
    fontSize: 18,
    height: 1.0,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle( // subtitle2 -> subtitle
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle( // body2 -> body1
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    color: darkText,
  );

  static const TextStyle caption = TextStyle( // Caption -> caption
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: lightText, // was lightText
  );

  static const TextStyle tansprentFontColor = TextStyle( // h5 -> headline
    fontFamily: 'WorkSans',
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.white,
  );

}
