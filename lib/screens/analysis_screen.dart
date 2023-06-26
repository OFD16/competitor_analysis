import 'package:fluent_ui/fluent_ui.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({Key? key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
        title: Container(
          margin: const EdgeInsets.only(left: 20),
          child: const Text(
            'Competitor Analysis',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      pane: NavigationPane(
        size: const NavigationPaneSize(
          openMinWidth: 250,
          openMaxWidth: 320,
        ),
        items: <NavigationPaneItem>[
          PaneItem(
            icon: const Icon(FluentIcons.home),
            title: const Text('Dashboard'),
            body: const Text('A'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.link),
            title: const Text('Analyze'),
            body: const Text('b'),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.reminder_person),
            title: const Text('Profile'),
            body: const Text('c'),
          ),
        ],
        selected: _currentPage,
        onChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}
