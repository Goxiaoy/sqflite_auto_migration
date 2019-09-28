import 'package:sqflite/sqflite.dart';

abstract class MigrationBase {
  const MigrationBase();

  ///up function executed during db upgrade
  Future up(Batch batch);

  ///up function executed during db downgrade
  Future down(Batch batch);
}
