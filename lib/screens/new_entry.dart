import 'package:flutter/material.dart';
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
              validator: (value) => nonEmptyField(value),
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

  List<Widget> formFields(BuildContext context) {
    return [
      TextFormField(
        autofocus: true,
        decoration:
            InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
        validator: (value) => nonEmptyField(value),
      ),
      SizedBox(height: 20),
      DropdownButtonFormField(
        items: [1, 2, 3, 4]
            .map((label) => DropdownMenuItem(
                  child: Text(label.toString()),
                  value: label,
                ))
            .toList(),
        hint: Text('Put thy rating here'),
        onChanged: (value) {},
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
        validator: (value) => nonEmptyField(value),
      ),
      SizedBox(height: 10),
      Builder(builder: (context) {
        return RaisedButton(
            onPressed: () => validateAndSave(context),
            child: Text('Save Entry'));
      })
    ];
  }

  void validateAndSave(BuildContext context) {
    final curState = formKey.currentState;

    if (curState.validate()) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Saving entry...')));
    }
  }
} // _NewEntryState

String nonEmptyField(String data) {
  if (data.isEmpty) {
    return 'This field cannot be empty';
  }
  return null;
}
