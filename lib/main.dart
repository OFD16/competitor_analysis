import 'package:flutter/material.dart';
import 'package:competitor_analysis/my_app.dart' as app;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Competitor Analyzer',
      theme: app.AppTheme.lightTheme, // Set light theme as the default
      darkTheme: app.AppTheme.darkTheme, // Set dark theme
      debugShowCheckedModeBanner: false,
      home: const app.HomeScreen(),
    );
  }
}

// theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: Colors.deepPurple,
//           background: const Color(0xff2c3837),
//           surface: const Color(0xff2c3837),
//           // primary: Colors.red,
//           // onPrimary: Colors.red,
//           primaryContainer: Colors.deepPurple, // floating action button color
//           // secondary: Colors.red,
//           // onPrimaryContainer: Colors.deepPurple,
//           // secondaryContainer: Colors.deepPurple,
//           // tertiaryContainer: Colors.deepPurple,
//           // secondaryContainer: Colors.red,
//           // onSecondaryContainer: Colors.red,
//           // tertiary: Colors.green,
//           // tertiaryContainer: Colors.red,
//         ),
//         useMaterial3: true,
//       ),
