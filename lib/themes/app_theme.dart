import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.blue,
    //accentColor: Colors.orange,
    scaffoldBackgroundColor: Colors.white,
    // Add more light theme configurations as needed
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    useMaterial3: true,
    // Customize dark theme properties based on your preference
    // Example:
    primaryColor: Colors.deepPurple,
    //accentColor: Colors.teal,
    scaffoldBackgroundColor: Colors.grey[900],
  );
}
