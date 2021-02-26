import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:journal/models/entry_dto.dart';
import 'package:journal/widgets/journal_scaffold.dart';

class NewEntry extends StatefulWidget {
  static final routeName = 'new';

  final void Function() modeSwitcher; // function to switch light/dark mode
  NewEntry(this.modeSwitcher);

  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  final formKey = GlobalKey<FormState>();
  EntryDto formData = EntryDto.sampler(); // sampler auto adds cur date

  @override
  Widget build(BuildContext context) {
    return journalScaffold(
      title: 'New Entry',
      body: pageBody(context),
      context: context,
      switcher: widget.modeSwitcher,
    );
  }

  Form pageBody(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(children: [
            TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                  labelText: 'Title', border: OutlineInputBorder()),
              validator: (value) => nonEmptyField(value),
              onSaved: (String value) => formData.title = value,
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              items: [1, 2, 3, 4]
                  .map((label) => DropdownMenuItem(
                        child: Text(label.toString()),
                        value: label,
                      ))
                  .toList(),
              hint: Text('Put your rating here'),
              onChanged: (value) {},
              // validator: (value) => nonEmptyField(value),
              onSaved: (int value) => formData.rating = value,
            ),
            TextFormField(
              autofocus: false,
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
              onSaved: (String value) => formData.body = value,
            ),
            SizedBox(height: 10),
            Builder(builder: (context) {
              return RaisedButton(
                  onPressed: () => validateAndSave(context),
                  child: Text('Save Entry'));
            })
          ])),
    );
  }

  void validateAndSave(BuildContext context) async {
    final curState = formKey.currentState;

    if (curState.validate()) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Saving entry...')));
      curState.save();
      // await deleteDatabase('journal.db'); // TODO: remove this line
      final Database db = await openDatabase('journal.db', version: 1,
          onCreate: (Database database, int version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS journal_entries(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, body TEXT NOT NULL, rating INTEGER NOT NULL, date TEXT NOT NULL);');
      });
      await db.transaction((txn) async {
        await txn.rawInsert(
            'INSERT INTO journal_entries(title, body, rating, date) values (?, ?, ?, ?)',
            [formData.title, formData.body, formData.rating, formData.dbDate]);
      });
      Navigator.of(context).pop();
    }
  }
} // _NewEntryState

String nonEmptyField(String data) {
  if (data.isEmpty) {
    return 'This field cannot be empty';
  }
  return null;
}
