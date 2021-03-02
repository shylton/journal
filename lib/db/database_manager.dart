import 'package:sqflite/sqflite.dart';

import 'package:journal/models/entry_dto.dart';
import 'package:journal/db/database_queries.dart';

class DatabaseManager {
  static DatabaseManager _instance;
  final Database db;

  DatabaseManager._hiddenConstructor({Database database}) : db = database;

  // returns the singleton DB Manager
  factory DatabaseManager.getInstance() {
    assert(_instance != null); // must be initialized first, how to do in one?
    return _instance;
  }

  // must be called before using this manager
  static Future initialize() async {
    // await deleteDatabase(DatabaseQueries.FILENAME); // REMOVE-ME: used in tests
    final db = await openDatabase(DatabaseQueries.FILENAME, version: 1,
        onCreate: (Database db, int version) async {
      db.execute(DatabaseQueries.CREATE_SCHEMA);
    });
    _instance = DatabaseManager._hiddenConstructor(database: db);
    print('db initialized.');
  }

  void saveEntry({EntryDto dto}) {
    db.transaction((txn) async {
      await txn.rawInsert(DatabaseQueries.INSERT_DTO,
          [dto.title, dto.body, dto.rating, dto.dbDate]);
    });
  }

  Future<List<Map>> selectEntries() {
    return db.rawQuery(DatabaseQueries.SELECT_ENTRIES);
  }

  Future<bool> hasEntries() async {
    List<Map> res = await selectEntries();
    if (res.isEmpty || res.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  // used in testing
  void deleteDB() async {
    await deleteDatabase(DatabaseQueries.FILENAME);
    initialize(); // reinitialize blank db
  }
}
