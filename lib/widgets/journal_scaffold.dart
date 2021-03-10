import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:journal/db/database_manager.dart';

/// Scaffold common to all pages. includes end drawer to switch theme
Widget journalScaffold(
    {@required String title,
    @required Widget body,
    @required BuildContext context,
    @required Function() switcher,
    FloatingActionButton button}) {
  return Scaffold(
    appBar: AppBar(title: Text(title), centerTitle: true),
    floatingActionButton: button, // will be null if undefined
    body: body,
    endDrawer: Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          DrawerHeader(
            child: null,
          ),
          ModeSwitch(switcher),
          deleteDbButton(),
        ],
      ),
    ),
  );
}

class ModeSwitch extends StatefulWidget {
  final void Function() changeMode;
  ModeSwitch(this.changeMode);

  @override
  _ModeSwitchState createState() => _ModeSwitchState();
}

/// Theme switching implemented here
class _ModeSwitchState extends State<ModeSwitch> {
  bool _darkMode = false;

  void initState() {
    super.initState();
    initMode();
  }

  void initMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _darkMode = prefs.getBool('darkMode') ?? false; // defaults to light
    });
  }

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

Widget deleteDbButton() {
  return Expanded(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: OutlinedButton(
        child: Text('DELETE DATABASE'),
        onPressed: () {
          final dbMgr = DatabaseManager.getInstance();
          dbMgr.deleteDB();
        },
      ),
    ),
  );
}
