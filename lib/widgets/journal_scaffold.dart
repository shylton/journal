import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget journalScaffold(
    String title, Widget body, BuildContext context, Function() switcher,
    {FloatingActionButton button}) {
  return Scaffold(
    appBar: AppBar(title: Text(title), centerTitle: true),
    floatingActionButton: button, // will be null if undefined
    body: body,
    endDrawer: Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: null,
          ),
          ModeSwitch(changeMode: switcher)
        ],
      ),
    ),
  );
}

class ModeSwitch extends StatefulWidget {
  final void Function() changeMode;
  ModeSwitch({Key key, this.changeMode}) : super(key: key);

  @override
  _ModeSwitchState createState() => _ModeSwitchState();
}

class _ModeSwitchState extends State<ModeSwitch> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text('Dark Mode'),
      value: _darkMode,
      onChanged: (bool value) {
        setState(() {
          _darkMode = value;
        });
        widget.changeMode();
      },
    );
  }
}
