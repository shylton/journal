import 'package:flutter/material.dart';

import 'package:journal/screens/new_entry.dart';

/// Button to add a new journal entry
FloatingActionButton addEntry(BuildContext context) {
    return FloatingActionButton(
        child: Text('+'),
        onPressed: () => {Navigator.pushNamed(context, NewEntry.routeName)},
      );
  }