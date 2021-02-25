import 'package:flutter/material.dart';
import 'package:journal/models/entry_dto.dart';

class EntryDetail extends StatelessWidget {
  final EntryDto entry;

  EntryDetail(this.entry);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(entry.dateString))),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(entry.body),
      ),
    );
  }
}
