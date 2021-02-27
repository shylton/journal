import 'package:flutter/material.dart';

import 'package:journal/db/database_manager.dart';
import 'package:journal/screens/entries_page.dart';
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
            TextFormField(
              decoration: InputDecoration(
                  labelText: 'Rating (1 to 4)', border: OutlineInputBorder()),
              validator: (value) => validateRating(value),
              onSaved: (String value) => formData.rating = int.parse(value),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 3,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: 'Body',
                border: OutlineInputBorder(),
              ),
              validator: (value) => nonEmptyField(value),
              onSaved: (String value) => formData.body = value,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlineButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop()),
                Builder(builder: (context) {
                  return RaisedButton(
                      onPressed: () => validateAndSave(context),
                      child: Text('Save Entry'));
                })
              ],
            )
          ])),
    );
  }

  void validateAndSave(BuildContext context) async {
    final curState = formKey.currentState;

    if (curState.validate()) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Saving entry...')));
      curState.save(); // saves all form fields to the formData object

      // await deleteDatabase('journal.db'); // TODO: remove this line
      final dbMgr = DatabaseManager.getInstance();
      dbMgr.saveEntry(dto: formData);
      Navigator.pushNamed(context, EntriesPage.routeName);
    }
  }
} // _NewEntryState

String nonEmptyField(String data) {
  if (data.isEmpty) {
    return 'This field cannot be empty';
  }
  return null;
}

String validateRating(String data) {
  try {
    final int rating = int.parse(data);
    if (rating < 1 || rating > 4) {
      return 'Please enter an integer between 1 and 4 inclusive.';
    }
  } catch (FormatException) {
    return 'Please enter a number between 1 and 4 inclusive.';
  }
  return null;
}
