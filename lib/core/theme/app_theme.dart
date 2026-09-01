import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();


//text theme
  static const TextTheme textTheme = TextTheme(

    headlineLarge: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold
    ),

    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600
    ),

    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),

    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),

    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
    )

  );

  //elebated button theme
  static const elevatedbuttonTheme = ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: WidgetStatePropertyAll(
        Size(double.infinity, 50),
      ),
    )
  );

//input decoration 
  static const inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(),

    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        width: 2,
      )
    ),

    errorBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 1),
    ),

    focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2),
    ),

  );



//light theme
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
      ),

      textTheme: textTheme,
      elevatedButtonTheme: elevatedbuttonTheme,
      inputDecorationTheme: inputDecorationTheme,
  );


 //dark theme
  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    textTheme: textTheme,
    elevatedButtonTheme: elevatedbuttonTheme,
    inputDecorationTheme: inputDecorationTheme,
  );
}