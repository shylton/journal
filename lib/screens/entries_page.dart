import 'package:flutter/material.dart';

import 'package:journal/db/database_manager.dart';
import 'package:journal/widgets/add_entry.dart';
import 'package:journal/widgets/journal_scaffold.dart';
import 'package:journal/screens/entry_detail.dart';
import 'package:journal/models/entry_dto.dart';

class EntriesPage extends StatefulWidget {
  static final routeName = 'entryList';

  final void Function() modeSwitcher; // function to switch light/dark mode
  EntriesPage(this.modeSwitcher);

  @override
  _EntriesPageState createState() => _EntriesPageState();
}

class _EntriesPageState extends State<EntriesPage> {
  List<EntryDto> entriesList;

  @override
  void initState() {
    super.initState();
    getEntries();
  }

  @override
  Widget build(BuildContext context) {
    return journalScaffold(
        title: 'Journal Entries',
        body: listOfEntries(context),
        context: context,
        switcher: widget.modeSwitcher,
        button: addEntry(context));
  }

  // used for testing
  List<EntryDto> genFakeList(int howMany) {
    return List<EntryDto>.generate(howMany, (int idx) => EntryDto.sampler());
  }

  // query the database and rebuild with the updated list
  void getEntries() async {
    final dbMgr = DatabaseManager.getInstance();
    List<Map> res = await dbMgr.selectEntries();

    final journalEntries = res.map((row) {
      return EntryDto(
          title: row['title'],
          body: row['body'],
          rating: row['rating'],
          datetime: DateTime.parse(row['date']));
    }).toList();

    print(journalEntries);
    setState(() {
      entriesList = journalEntries;
    });
  }

  Widget listOfEntries(BuildContext context) {
    return entriesList == null
        ? Text('Loading...')
        : ListView.builder(
            itemCount: entriesList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(entriesList[index].title),
                subtitle: Text(entriesList[index].dateString),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EntryDetail(
                              entriesList[index], widget.modeSwitcher)));
                },
              );
            },
          );
  }
}
