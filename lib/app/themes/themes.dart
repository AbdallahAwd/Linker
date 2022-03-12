import 'package:flutter/material.dart';
import 'package:linker/app/themes/colors.dart';

class Themes {
  bool isColor = false;
  static ThemeData lightTheme = ThemeData(
    checkboxTheme: const CheckboxThemeData(),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: mainColor,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: mainColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      primary: mainColor,
    )),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.black),
      elevation: 2,
      backgroundColor: Colors.white,
      actionsIconTheme: const IconThemeData(color: Colors.black, opacity: 0.8),
      titleTextStyle: TextStyle(
        color: Colors.grey.shade800,
      ),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontFamily: 'Candara',
        fontSize: 15,
        color: textColor,
        letterSpacing: 1.335,
        fontWeight: FontWeight.w700,
        height: 1,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColorDark: mainColor,
    primaryColor: mainColor,
    primaryColorLight: mainColor,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF141414),
    ),
    scaffoldBackgroundColor: const Color(0xFF141414),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: mainColor,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: mainColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      primary: mainColor,
    )),
    appBarTheme: const AppBarTheme(
      elevation: 2,
      backgroundColor: Color(0xFF141414),
      actionsIconTheme: IconThemeData(color: Colors.white, opacity: 0.8),
    ),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        fontFamily: 'Candara',
        fontSize: 18,
        color: Colors.white,
        letterSpacing: 1.335,
        fontWeight: FontWeight.w700,
        height: 1,
      ),
    ),
  );

  // ThemeData(
  // bottomSheetTheme: const BottomSheetThemeData(
  //   backgroundColor: Color(0xFF141414),
  // ),
  // scaffoldBackgroundColor: const Color(0xFF141414),
  // outlinedButtonTheme: OutlinedButtonThemeData(
  //   style: OutlinedButton.styleFrom(
  //     primary: isSecondColor ? secondColor: mainColor ,
  //   ),
  // ),
  // floatingActionButtonTheme: const FloatingActionButtonThemeData(
  //   backgroundColor: isSecondColor ? secondColor: mainColor ,
  // ),
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(
  //   primary: isSecondColor ? secondColor: mainColor ,
  // )),
  // appBarTheme: AppBarTheme(
  //   elevation: 2,
  //   backgroundColor: const Color(0xFF141414),
  //   actionsIconTheme: const IconThemeData(color: Colors.white, opacity: 0.8),
  //   titleTextStyle: TextStyle(
  //     color: Colors.grey.shade800,
  //   ),
  // ),
  // textTheme: const TextTheme(
  //   bodyText1: TextStyle(
  //     fontFamily: 'Candara',
  //     fontSize: 18,
  //     color: Colors.white,
  //     letterSpacing: 1.335,
  //     fontWeight: FontWeight.w700,
  //     height: 1,
  //   ),
  // ),
  //  );
}
