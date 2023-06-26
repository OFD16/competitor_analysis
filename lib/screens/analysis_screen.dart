import 'package:fluent_ui/fluent_ui.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Text(
            'Competitor Analysis',
            style: TextStyle(
              fontSize: 32,
              color: Colors.red,
            ),
          ),
        ),
        backgroundColor: Colors.teal,
        automaticallyImplyLeading: false,
      ),
      content: Container(
        // Provide the content property with a widget
        child: Text('Content goes here'),
      ),
    );
  }
}
