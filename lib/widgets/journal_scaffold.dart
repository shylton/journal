import 'package:flutter/material.dart';

Widget journalScaffold(String title, Widget body, BuildContext context,
    {FloatingActionButton button}) {
  bool _isToggled = true;
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
          ModeSwitch()
        ],
      ),
    ),
  );
}

class ModeSwitch extends StatefulWidget {
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
      },
    );
  }
}
