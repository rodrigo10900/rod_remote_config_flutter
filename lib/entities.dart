import 'package:isar_community/isar.dart';

part 'entities.g.dart';

@collection
class RemoteConfigDataEnt {
  Id id = Isar.autoIncrement;
  int? timestamp;
  String? data;
}
