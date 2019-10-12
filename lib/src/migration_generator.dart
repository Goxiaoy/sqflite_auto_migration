import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:sqflite_auto_migration/src/migration_data.dart';
import 'migration_version.dart';

class MigrationDataGenerator extends GeneratorForAnnotation<MigrationVersion> {
  static MigrationData migrationData = MigrationData();

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    var version = annotation.peek('version').intValue;
    migrationData.add(version, element, buildStep);
    return null;
  }
}

