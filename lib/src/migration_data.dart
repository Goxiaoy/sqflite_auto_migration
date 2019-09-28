import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';

class MigrationData {
  Map<int, String> _migrations = {};
  List<String> imports = [];

  void add(int version, ClassElement element, BuildStep buildStep) {
    if (_migrations.containsKey(version)) {
      throw "duplicate migration $version";
    }
    _migrations[version] = element.displayName;
    print(buildStep.inputId.path);
    if (buildStep.inputId.path.contains('lib/')) {
      print(buildStep.inputId.path);
      imports.add(
          "package:${buildStep.inputId.package}/${buildStep.inputId.path.replaceFirst('lib/', '')}");
    } else {
      imports.add("${buildStep.inputId.path}");
    }
  }

  ///get stored migrations
  List<MapEntry<int, String>> get migrations {
    var items = _migrations.entries.toList();
    items.sort((a, b) => a.key.compareTo(b.key));
    return items;
  }
}
