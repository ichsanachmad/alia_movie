import 'package:alia_movie/data/local/entity/movie_schedule.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'local_repository.g.dart';

@UseMoor(tables: [MovieSchedule])
class LocalRepository extends _$LocalRepository {
  static const DB_PATH = "movie_schedule.sqlite";

  LocalRepository()
      : super(
          FlutterQueryExecutor.inDatabaseFolder(
              path: DB_PATH, logStatements: true),
        );

  @override
  int get schemaVersion => 1;

  Stream<List<MovieScheduleData>> getMovieScheduleStream() =>
      select(movieSchedule).watch();

  Future<bool> isMovieScheduleAdded(int id) async {
    List<MovieScheduleData> res =
        await (select(movieSchedule)..where((tbl) => tbl.id.equals(id))).get();

    if (res.length > 0) return true;
    return false;
  }

  Future<List<MovieScheduleData>> movieScheduleById(int id) async {
    List<MovieScheduleData> res =
        await (select(movieSchedule)..where((tbl) => tbl.id.equals(id))).get();

    return res;
  }

  Future insertMovieSchedule(MovieScheduleCompanion movieScheduleData) =>
      into(movieSchedule).insert(movieScheduleData);

  Future updateMovieSchedule(MovieScheduleCompanion movieScheduleData) =>
      (update(movieSchedule)
            ..where((tbl) => (tbl.id.equals(movieScheduleData.id.value))))
          .write(movieScheduleData);

  Future<void> deleteMovieSchedule(
          MovieScheduleCompanion movieScheduleData) async =>
      await (delete(movieSchedule)
            ..where((tbl) => (tbl.id.equals(movieScheduleData.id.value))))
          .go();
}

LocalRepository? _instance;
LocalRepository get getLocalRepositoryInstance {
  return _instance ??= LocalRepository();
}
