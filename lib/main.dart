import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:journal/db/database_manager.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);
  await DatabaseManager.initialize();
  final dbMgr = DatabaseManager.getInstance();
  final hasEntries = await dbMgr.hasEntries();
  // awaiting for sharedprefs here so we dont have to await in children
  runApp(App(await SharedPreferences.getInstance(), hasEntries));
}
