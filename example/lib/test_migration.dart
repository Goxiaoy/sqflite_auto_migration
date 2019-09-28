import 'package:sqflite_migration/sqflite_migration.dart';
import 'package:sqflite/sqflite.dart';

@MigrationVersion(1)
class TestMigrationOne extends MigrationBase {
  @override
  Future down(Batch batch) async {
    batch.execute('DROP TABLE IF EXISTS Company');
    batch.execute('''CREATE TABLE Company (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT)''');
  }

  @override
  Future up(Batch batch) async {
    batch.execute('DROP TABLE Company');
    return null;
  }
}

@MigrationVersion(2)
class TestMigrationTwo extends MigrationBase {
  @override
  Future down(Batch batch) async {
    batch.execute('DROP TABLE IF EXISTS Company');
    batch.execute('''CREATE TABLE Company (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT)''');
  }

  @override
  Future up(Batch batch) async {
    batch.execute('DROP TABLE Company');
    return null;
  }
}
