import 'package:flutter/material.dart';

import 'package:journal/widgets/add_entry.dart';
import 'package:journal/widgets/journal_scaffold.dart';
import 'package:journal/screens/entry_detail.dart';
import 'package:journal/models/entry_dto.dart';

class EntriesPage extends StatelessWidget {
  static final routeName = 'entryList';
  final void Function() modeSwitcher; // function to switch light/dark mode
  EntriesPage(this.modeSwitcher);

  @override
  Widget build(BuildContext context) {
    return journalScaffold(
        title: 'Journal Entries',
        body: listOfEntries(context),
        context: context,
        switcher: modeSwitcher,
        button: addEntry(context));
  }

  List<EntryDto> genEntryList(int howMany) {
    return List<EntryDto>.generate(howMany, (int idx) => EntryDto.sampler());
  }

  Widget listOfEntries(BuildContext context) {
    final entriesList = genEntryList(19);

    return ListView.builder(
      itemCount: entriesList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(entriesList[index].title),
          subtitle: Text(entriesList[index].dateString),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EntryDetail(entriesList[index], modeSwitcher)));
          },
        );
      },
    );
  }
}
