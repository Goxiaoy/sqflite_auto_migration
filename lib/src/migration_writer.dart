import 'package:sqflite_auto_migration/src/migration_data.dart';
import 'tpl.dart';
import 'package:mustache4dart/mustache4dart.dart';

class MigrationWriter {
  final MigrationData _migrationData;

  MigrationWriter(this._migrationData);

  String write() {
    var sorted = _migrationData.migrations;
    print("detected migrations $sorted");
    var hasVersion = sorted.length > 0;
    return render(tpl, <String, dynamic>{
      'imports': _migrationData.imports
          .toSet()
          .map((p) => <String, String>{'path': p})
          .toList(),
      'migrations': sorted
          .map((p) => p.key.toString() + ": " + p.value + "()")
          .join(",\n  "),
      'latestVersion': hasVersion ? sorted.last.key.toString() : 'null',
      'hasVersion': hasVersion
    });
  }
}
