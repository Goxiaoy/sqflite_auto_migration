# sqflite_auto_migration

use code-gen to generate sqflite OpenDatabaseOptions

## Getting Started

### install

Add to you pubspec.yaml

```
dependencies:
    sqflite_auto_migration:

dev_dependencies:
    build_runner: '>=0.9.1'

```


Write a migration class like

```
import 'package:sqflite_auto_migration/sqflite_auto_migration.dart';
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

```

### generate migration function file


```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

And you will see in you `lib/generated/migration_function.dart`

```
OpenDatabaseOptions get options => OpenDatabaseOptions(
    //latest version define in the migrations
    version: 3,
    onCreate: (db, version) async {
      var batch = db.batch();
      for (var m in migrations.entries) {
        await m.value.up(batch);
      }
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      var batch = db.batch();
      for (var m in migrations.entries) {
        if (m.key > oldVersion && m.key <= newVersion) await m.value.up(batch);
      }
    },
    onDowngrade: (db, oldVersion, newVersion) async {
      var batch = db.batch();
      for (var m in migrations.entries) {
        if (m.key <= oldVersion && m.key > newVersion)
          await m.value.down(batch);
      }
    });
```

Use this option to open your sqlite

This project is highly inspired by [annotation_route](https://github.com/alibaba-flutter/annotation_route)

