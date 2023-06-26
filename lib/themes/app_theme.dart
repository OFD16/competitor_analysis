import 'package:fluent_ui/fluent_ui.dart';

class AppTheme {
  static FluentThemeData get lightTheme => FluentThemeData(
        brightness: Brightness.light,
        // primaryColor: const Color(0xFF0000FF), // Replace with your desired primary color
        // accentColor: Color(0xFFFF0000)
        //     .toAccentColor(), // Replace with your desired accent color
        scaffoldBackgroundColor: Colors.white,
        // Add more light theme configurations as needed
      );

  static FluentThemeData get darkTheme => FluentThemeData(
        brightness: Brightness.dark,
        // primaryColor: const Color(0xFF000000), // Replace with your desired primary color
        // accentColor: const Color(0xFFFFFFFF)
        //     .toAccentColor(), // Replace with your desired accent color
        // scaffoldBackgroundColor: Colors.grey[900],
        // Add more dark theme configurations as needed
      );
}
