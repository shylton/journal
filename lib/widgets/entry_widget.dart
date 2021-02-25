import 'package:flutter/material.dart';

class EntryWidget extends StatelessWidget {
  final String title;
  final String body;

  EntryWidget({this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(body),
          Divider()
        ],
      ),
    );
  }
}
