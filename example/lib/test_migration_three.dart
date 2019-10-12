import 'package:sqflite_auto_migration/sqflite_auto_migration.dart';
import 'package:sqflite/sqflite.dart';

@MigrationVersion(3)
class TestMigrationThree extends MigrationBase {
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
