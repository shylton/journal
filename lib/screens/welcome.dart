import 'package:flutter/material.dart';
import 'package:journal/screens/new_entry.dart';
import 'package:journal/widgets/journal_scaffold.dart';

import 'entries_page.dart';

class Welcome extends StatelessWidget {
  static final routeName = '/';

  // user registration info?
  @override
  Widget build(BuildContext context) {
    final pageBody = Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [label(context), button(context), button2(context)]),
    );

    return journalScaffold('Welcome', pageBody, context);
  }

  Widget label(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'Welcome to the journal app. Click the button below to add a new journal entry',
        style: Theme.of(context).textTheme.headline6,
        textAlign: TextAlign.center,
      ),
    );
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
