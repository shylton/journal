import 'package:flutter/material.dart';

class NewEntry extends StatelessWidget {
  static final routeName = 'new';
  // hit cancel or save button, goes back [list or welcome]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: Text('New entry goes here',
                style: Theme.of(context).textTheme.headline4)));
  }
}
