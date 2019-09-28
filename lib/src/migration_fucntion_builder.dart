import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;

import 'migration_writer.dart';
import 'migration_generator.dart';

class MiragtionFunctionBuilder implements Builder {

  static final _allFilesInLib = new Glob('lib/**');

  static AssetId _allFileOutput(BuildStep buildStep) {
    return new AssetId(
      buildStep.inputId.package,
      p.join('lib', 'generated','migration_function.dart'),
    );
  }

  @override
  Map<String, List<String>> get buildExtensions {
    return const {
      r'$lib$': const ['generated/migration_function.dart'],
    };
  }

  @override
  Future<void> build(BuildStep buildStep) async {
    final files = <String>[];
    await for (final input in buildStep.findAssets(_allFilesInLib)) {
      files.add(input.path);
    }
    final output = _allFileOutput(buildStep);
    //get migration
    return buildStep.writeAsString(output, MigrationWriter(MigrationDataGenerator.migrationData).write());
  }
}