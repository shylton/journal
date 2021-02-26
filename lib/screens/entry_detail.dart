import 'package:flutter/material.dart';

import 'package:journal/models/entry_dto.dart';
import 'package:journal/widgets/add_entry.dart';
import 'package:journal/widgets/journal_scaffold.dart';

class EntryDetail extends StatelessWidget {
  static final routeName = 'entryDetail';
  final EntryDto entry;
  final void Function() modeSwitcher; // function to switch light/dark mode
  EntryDetail(this.entry, this.modeSwitcher, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // body to be passed to the scaffold, contains rating and full text
    final pageBody = Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Rating: ${entry.rating.toString()}'),
          Divider(),
          Text(entry.body),
        ],
      ),
    );

    return journalScaffold(
        title: entry.shortDateString,
        body: pageBody,
        context: context,
        switcher: modeSwitcher,
        button: addEntry(context));
  }
}
