const String tpl="""
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_migration/sqflite_migration.dart';

{{#imports}}
import '{{{path}}}';
{{/imports}}

final Map<int, MigrationBase> migrations={{{migrations}}};

OpenDatabaseOptions get options => OpenDatabaseOptions(
    //latest version define in the migrations
    version: {{{latestVersion}}},
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


""";