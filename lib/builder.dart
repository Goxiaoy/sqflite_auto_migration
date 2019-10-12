import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:sqflite_auto_migration/src/migration_fucntion_builder.dart';
import 'src/migration_generator.dart';

///migration builder
///
/// get all migrations. on create,
Builder migrationDataBuilder(BuilderOptions options) =>
    LibraryBuilder(MigrationDataGenerator(), generatedExtension: '.empty.dart');

Builder migrationFunctionBuilder(BuilderOptions options) =>
    MiragtionFunctionBuilder();
