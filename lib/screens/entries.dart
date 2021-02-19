import 'package:flutter/material.dart';

import 'new_entry.dart';

class Entries extends StatelessWidget {
  static final routeName = 'entryList';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entries List')),
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: () => {Navigator.pushNamed(context, NewEntry.routeName)},
      ),
      body: Column(
        children: [Placeholder(), Expanded(child: Placeholder())],
      ),
    );
  }
}
