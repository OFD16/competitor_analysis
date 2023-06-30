import 'package:fluent_ui/fluent_ui.dart';

import './index.dart' as screens;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _currentPage = 0;

class _HomeScreenState extends State<HomeScreen> {
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
            icon: const Icon(FluentIcons.app_icon_default),
            title: const Text('Dashboard'),
            body: const screens.DashboardScreen(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.chart),
            title: const Text('Analyze'),
            body: const screens.AnalysisScreen(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.user_clapper),
            title: const Text('Profile'),
            body: const screens.ProfileScreen(),
          ),
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: const screens.SettingsScreen(),
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

    // const SafeArea(
    //   child: Text('HomeScreen'),
    // );
  }
}
