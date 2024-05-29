import 'package:flutter/material.dart';


class AppTheme {
  static ThemeData mainTheme(BuildContext context) {
  
    return ThemeData(
      backgroundColor: Colors.white,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Sans',
          fontWeight: FontWeight.normal,
         // color: Colors.grey[300],
          fontSize: 35
        ),
        titleMedium: TextStyle(
          fontFamily: 'Alatsi',
          fontWeight: FontWeight.normal,
          color: Colors.grey[300],
          fontSize: 14
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Sans',
          fontSize: 18,
          color: Colors.white,
         
        ),
        titleSmall: TextStyle(
          fontFamily: 'Sans',
          fontSize: 15,
          //fontWeight: FontWeight.normal,
          color: Colors.black,
         
        ),
      ),
    );
  }
}
