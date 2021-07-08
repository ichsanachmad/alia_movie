// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Base<T> _$BaseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return Base<T>(
    page: json['page'] as int,
    results: fromJsonT(json['results']),
  );
}

Map<String, dynamic> _$BaseToJson<T>(
  Base<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'page': instance.page,
      'results': toJsonT(instance.results),
    };
