import 'package:sqflite/sqflite.dart';
import 'package:sqflite_auto_migration/sqflite_auto_migration.dart';

import 'package:sqflite_auto_migration_example/test_migration_three.dart';
import 'package:sqflite_auto_migration_example/test_migration.dart';

final Map<int, MigrationBase> migrations={1: TestMigrationOne(), 2: TestMigrationTwo(), 3: TestMigrationThree()};

OpenDatabaseOptions get options => OpenDatabaseOptions(
    //latest version define in the migrations
    version: 3,
    onCreate: (db, version) async {
      var batch = db.batch();
      for (var m in migrations.entries) {
        await m.value.up(batch);
      }
      await batch.commit();
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
      await batch.commit();
    });



