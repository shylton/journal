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
  bool darkMode; // true =  darkMode ON

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
      Welcome.routeName: (context) => Welcome(switchTheme),
      NewEntry.routeName: (context) => NewEntry(switchTheme),
      EntriesPage.routeName: (context) => EntriesPage(switchTheme),
      EntryDetail.routeName: (context) => EntryDetail(null, null)
    };
    ThemeData theme = darkMode ? ThemeData.dark() : ThemeData.light();
    return MaterialApp(
      title: 'Journal',
      theme: theme,
      routes: routes,
    );
  }
}
