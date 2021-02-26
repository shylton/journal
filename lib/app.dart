import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:journal/screens/entries_page.dart';
import 'package:journal/screens/new_entry.dart';
import 'package:journal/screens/welcome.dart';

class App extends StatefulWidget {
  // This widget is the root of the application.
  final SharedPreferences preferences;
  static final routes = {
    Welcome.routeName: (context) => Welcome(),
    NewEntry.routeName: (context) => NewEntry(),
    EntriesPage.routeName: (context) => EntriesPage()
  };

  App({Key key, @required this.preferences}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool darkMode;

  void initState() {
    super.initState();
    darkMode = widget.preferences.getBool('darkMode') ?? false;
  }

  void darkTheme(bool newValue) {
    widget.preferences.setBool('darkMode', newValue);
    setState(() {
      darkMode = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    darkTheme(true);
    ThemeData theme = darkMode ? ThemeData.dark() : ThemeData.light();
    return MaterialApp(
      title: 'Journal',
      theme: theme,
      // ThemeData(
      //   primarySwatch: Colors.teal,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      routes: App.routes,
    );
  }
}

// layout configs go inside ea screen?
class VerticalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lime,
    );
  }
}

class HorizontalLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: Container(color: Colors.lightGreen)),
        Expanded(
            child: Container(
          color: Colors.deepOrange,
        ))
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  Widget getLayout(BuildContext context, BoxConstraints constraints) =>
      constraints.maxWidth < 500 ? VerticalLayout() : HorizontalLayout();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("adaptive layout")),
      endDrawer: Drawer(),
      body: Welcome(),
    );
  }
}
