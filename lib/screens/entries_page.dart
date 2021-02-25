import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/entry_widget.dart';
import '../models/entry_dto.dart';
import 'new_entry.dart';

class EntriesPage extends StatelessWidget {
  static final routeName = 'entryList';

  @override
  Widget build(BuildContext context) {
    final entriesList = genEntryList(19);
    final dtFormat = DateFormat("EEEE, MMMM d, y");

    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Journal Entries'))),
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: () => {Navigator.pushNamed(context, NewEntry.routeName)},
      ),
      body: ListView.builder(
        itemCount: entriesList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(entriesList[index].title),
            subtitle: Text(dtFormat.format(entriesList[index].date)),
          );
        },
      ),
    );
  }
}

List<EntryDto> genEntryList(int howMany) {
  return List<EntryDto>.generate(howMany, (int idx) => EntryDto.sampler());
}
