import 'package:flutter/material.dart';

import 'package:journal/widgets/add_entry.dart';
import 'package:journal/widgets/journal_scaffold.dart';
import 'package:journal/screens/entry_detail.dart';
import 'package:journal/models/entry_dto.dart';
import 'package:sqflite/sqflite.dart';

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

  List<EntryDto> genFakeList(int howMany) {
    return List<EntryDto>.generate(howMany, (int idx) => EntryDto.sampler());
  }

  void getEntries() async {
    final Database database = await openDatabase('journal.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, body TEXT NOT NULL, rating INTEGER NOT NULL, date TEXT NOT NULL);');
    });
    List<Map> res = await database.rawQuery('SELECT * FROM journal_entries;');
    print(res);
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
    // entriesList = genFakeList(19);

    return entriesList == null
        ? Text('loading')
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
