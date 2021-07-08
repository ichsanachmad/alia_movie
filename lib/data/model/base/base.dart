import 'package:json_annotation/json_annotation.dart';

part 'base.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Base<T> {
  late int page;
  late T results;

  Base({required this.page, required this.results});

  factory Base.fromJson(
          Map<String, dynamic> json, T Function(Object? value) fromJsonT) =>
      _$BaseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseToJson(this, toJsonT);
}
