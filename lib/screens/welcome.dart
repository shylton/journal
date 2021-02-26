import 'package:flutter/material.dart';

import 'package:journal/widgets/add_entry.dart';
import 'package:journal/widgets/journal_scaffold.dart';
import 'entries_page.dart';

class Welcome extends StatelessWidget {
  static final routeName = '/';
  final void Function() modeSwitcher; // function to switch light/dark mode
  Welcome(this.modeSwitcher);

  @override
  Widget build(BuildContext context) {
    // build the body to pass to the Scaffold
    final pageBody = Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [label(context), button2(context)]),
    );

    return journalScaffold(
        title: 'Welcome',
        body: pageBody,
        context: context,
        switcher: modeSwitcher,
        button: addEntry(context));
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
        child: Text('See List'),
        onPressed: () {
          Navigator.pushNamed(context, EntriesPage.routeName);
        });
  }
}
