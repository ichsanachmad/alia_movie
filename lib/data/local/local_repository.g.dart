// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_repository.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class MovieScheduleData extends DataClass
    implements Insertable<MovieScheduleData> {
  final int id;
  final String title;
  final String imagePath;
  final String releaseDate;
  final String overview;
  final String date;
  final String note;
  MovieScheduleData(
      {required this.id,
      required this.title,
      required this.imagePath,
      required this.releaseDate,
      required this.overview,
      required this.date,
      required this.note});
  factory MovieScheduleData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MovieScheduleData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      imagePath: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image_path'])!,
      releaseDate: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}release_date'])!,
      overview: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}overview'])!,
      date: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date'])!,
      note: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}note'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['image_path'] = Variable<String>(imagePath);
    map['release_date'] = Variable<String>(releaseDate);
    map['overview'] = Variable<String>(overview);
    map['date'] = Variable<String>(date);
    map['note'] = Variable<String>(note);
    return map;
  }

  MovieScheduleCompanion toCompanion(bool nullToAbsent) {
    return MovieScheduleCompanion(
      id: Value(id),
      title: Value(title),
      imagePath: Value(imagePath),
      releaseDate: Value(releaseDate),
      overview: Value(overview),
      date: Value(date),
      note: Value(note),
    );
  }

  factory MovieScheduleData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return MovieScheduleData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
      releaseDate: serializer.fromJson<String>(json['releaseDate']),
      overview: serializer.fromJson<String>(json['overview']),
      date: serializer.fromJson<String>(json['date']),
      note: serializer.fromJson<String>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'imagePath': serializer.toJson<String>(imagePath),
      'releaseDate': serializer.toJson<String>(releaseDate),
      'overview': serializer.toJson<String>(overview),
      'date': serializer.toJson<String>(date),
      'note': serializer.toJson<String>(note),
    };
  }

  MovieScheduleData copyWith(
          {int? id,
          String? title,
          String? imagePath,
          String? releaseDate,
          String? overview,
          String? date,
          String? note}) =>
      MovieScheduleData(
        id: id ?? this.id,
        title: title ?? this.title,
        imagePath: imagePath ?? this.imagePath,
        releaseDate: releaseDate ?? this.releaseDate,
        overview: overview ?? this.overview,
        date: date ?? this.date,
        note: note ?? this.note,
      );
  @override
  String toString() {
    return (StringBuffer('MovieScheduleData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('imagePath: $imagePath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('overview: $overview, ')
          ..write('date: $date, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(
              imagePath.hashCode,
              $mrjc(
                  releaseDate.hashCode,
                  $mrjc(overview.hashCode,
                      $mrjc(date.hashCode, note.hashCode)))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieScheduleData &&
          other.id == this.id &&
          other.title == this.title &&
          other.imagePath == this.imagePath &&
          other.releaseDate == this.releaseDate &&
          other.overview == this.overview &&
          other.date == this.date &&
          other.note == this.note);
}

class MovieScheduleCompanion extends UpdateCompanion<MovieScheduleData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> imagePath;
  final Value<String> releaseDate;
  final Value<String> overview;
  final Value<String> date;
  final Value<String> note;
  const MovieScheduleCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.overview = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
  });
  MovieScheduleCompanion.insert({
    required int id,
    required String title,
    required String imagePath,
    required String releaseDate,
    required String overview,
    required String date,
    required String note,
  })  : id = Value(id),
        title = Value(title),
        imagePath = Value(imagePath),
        releaseDate = Value(releaseDate),
        overview = Value(overview),
        date = Value(date),
        note = Value(note);
  static Insertable<MovieScheduleData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? imagePath,
    Expression<String>? releaseDate,
    Expression<String>? overview,
    Expression<String>? date,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (imagePath != null) 'image_path': imagePath,
      if (releaseDate != null) 'release_date': releaseDate,
      if (overview != null) 'overview': overview,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
    });
  }

  MovieScheduleCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? imagePath,
      Value<String>? releaseDate,
      Value<String>? overview,
      Value<String>? date,
      Value<String>? note}) {
    return MovieScheduleCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      imagePath: imagePath ?? this.imagePath,
      releaseDate: releaseDate ?? this.releaseDate,
      overview: overview ?? this.overview,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (releaseDate.present) {
      map['release_date'] = Variable<String>(releaseDate.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovieScheduleCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('imagePath: $imagePath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('overview: $overview, ')
          ..write('date: $date, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $MovieScheduleTable extends MovieSchedule
    with TableInfo<$MovieScheduleTable, MovieScheduleData> {
  final GeneratedDatabase _db;
  final String? _alias;
  $MovieScheduleTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER', requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _imagePathMeta = const VerificationMeta('imagePath');
  late final GeneratedColumn<String?> imagePath = GeneratedColumn<String?>(
      'image_path', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  late final GeneratedColumn<String?> releaseDate = GeneratedColumn<String?>(
      'release_date', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _overviewMeta = const VerificationMeta('overview');
  late final GeneratedColumn<String?> overview = GeneratedColumn<String?>(
      'overview', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<String?> date = GeneratedColumn<String?>(
      'date', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  final VerificationMeta _noteMeta = const VerificationMeta('note');
  late final GeneratedColumn<String?> note = GeneratedColumn<String?>(
      'note', aliasedName, false,
      typeName: 'TEXT', requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, imagePath, releaseDate, overview, date, note];
  @override
  String get aliasedName => _alias ?? 'movie_schedule';
  @override
  String get actualTableName => 'movie_schedule';
  @override
  VerificationContext validateIntegrity(Insertable<MovieScheduleData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    if (data.containsKey('release_date')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['release_date']!, _releaseDateMeta));
    } else if (isInserting) {
      context.missing(_releaseDateMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(_overviewMeta,
          overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta));
    } else if (isInserting) {
      context.missing(_overviewMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  MovieScheduleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MovieScheduleData.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MovieScheduleTable createAlias(String alias) {
    return $MovieScheduleTable(_db, alias);
  }
}

abstract class _$LocalRepository extends GeneratedDatabase {
  _$LocalRepository(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $MovieScheduleTable movieSchedule = $MovieScheduleTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [movieSchedule];
}
