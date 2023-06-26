import 'package:competitor_analysis/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Competitor Analyzer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          background: const Color(0xff2c3837),
          surface: const Color(0xff2c3837),
          // primary: Colors.red,
          // onPrimary: Colors.red,
          primaryContainer: Colors.deepPurple, // floating action button color
          // secondary: Colors.red,
          // onPrimaryContainer: Colors.deepPurple,
          // secondaryContainer: Colors.deepPurple,
          // tertiaryContainer: Colors.deepPurple,
          // secondaryContainer: Colors.red,
          // onSecondaryContainer: Colors.red,
          // tertiary: Colors.green,
          // tertiaryContainer: Colors.red,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
