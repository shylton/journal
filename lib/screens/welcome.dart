import 'package:flutter/material.dart';
import 'package:journal/screens/new_entry.dart';

import 'entries_page.dart';

class Welcome extends StatelessWidget {
  static final routeName = '/';
  // user registration info?
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text('Welcome'))),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              label(context),
              button(context),
              button2(context)
            ])));
  }

  Widget label(BuildContext context) {
    return Text('Welcome', style: Theme.of(context).textTheme.headline4);
  }

  Widget button2(BuildContext context) {
    return RaisedButton(
        child: Text('List'),
        onPressed: () {
          Navigator.pushNamed(context, EntriesPage.routeName);
        });
  }

  Widget button(BuildContext context) {
    return RaisedButton(
        child: Text('Add new journal entry'),
        onPressed: () {
          gotoNew(context);
        });
  }

  void gotoNew(BuildContext context) {
    // DONE
    Navigator.pushNamed(context, NewEntry.routeName);
  }
}
