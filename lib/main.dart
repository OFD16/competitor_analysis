import 'package:fluent_ui/fluent_ui.dart';
import 'package:competitor_analysis/my_app.dart' as app;
import './screens/index.dart' as screens;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Competitor Analyzer',
      theme: app.AppTheme.lightTheme, // Set light theme as the default
      darkTheme: app.AppTheme.darkTheme, // Set dark theme
      debugShowCheckedModeBanner: false,
      home: const screens.HomeScreen(),
    );
  }
}
