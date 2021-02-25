import 'package:flutter/material.dart';
import 'package:journal/screens/entries_page.dart';
import 'package:journal/screens/new_entry.dart';
import 'package:journal/screens/welcome.dart';

class App extends StatelessWidget {
  // This widget is the root of the application.
    static final routes = {
    Welcome.routeName: (context) => Welcome(),
    NewEntry.routeName: (context) => NewEntry(),
    EntriesPage.routeName: (context) => EntriesPage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Journal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
