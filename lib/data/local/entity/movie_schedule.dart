import 'package:moor_flutter/moor_flutter.dart';

class MovieSchedule extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get imagePath => text()();
  TextColumn get releaseDate => text()();
  TextColumn get overview => text()();
  TextColumn get date => text()();
  TextColumn get note => text()();
}
