/// model class holds for database query strings
class DatabaseQueries {
  static const String FILENAME = 'journal.sqlite3.db';

  static const String CREATE_SCHEMA =
      '''CREATE TABLE IF NOT EXISTS journal_entries(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    rating INTEGER NOT NULL,
    date TEXT NOT NULL);
  ''';

  static const String INSERT_DTO =
      '''INSERT INTO journal_entries(title, body, rating, date) 
      values (?, ?, ?, ?);''';

  static const String SELECT_ENTRIES = 'SELECT * FROM journal_entries;';
}
