import 'package:flutter/material.dart';
import 'package:journal/screens/entry_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:journal/screens/entries_page.dart';
import 'package:journal/screens/new_entry.dart';
import 'package:journal/screens/welcome.dart';

/// this is the root. must be stateful in order to switch dark/light themes
class App extends StatefulWidget {
  final SharedPreferences preferences;

  App({Key key, @required this.preferences}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool darkMode;  // true =  darkMode ON

  void initState() {
    super.initState();
    darkMode = widget.preferences.getBool('darkMode') ?? false;
  }

  void switchTheme() {
    widget.preferences
        .setBool('darkMode', !widget.preferences.getBool('darkMode'));
    setState(() {
      darkMode = widget.preferences.getBool('darkMode');
    });
  }

  @override
  Widget build(BuildContext context) {
    final routes = {
      Welcome.routeName: (context) => Welcome(changeMode: switchTheme),
      NewEntry.routeName: (context) => NewEntry(),
      EntriesPage.routeName: (context) => EntriesPage(),
      EntryDetail.routeName: (context) => EntryDetail(null)
    };
    ThemeData theme = darkMode ? ThemeData.dark() : ThemeData.light();
    return MaterialApp(
      title: 'Journal',
      theme: theme,
      // ThemeData(
      //   primarySwatch: Colors.teal,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      routes: routes,
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
