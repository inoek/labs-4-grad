import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'person_bundle.freezed.dart';

part 'person_bundle.g.dart';

@freezed
class PersonBundle with _$PersonBundle {
  factory PersonBundle({
    String? firstName,
    String? lastName,
    String? direction,
    String? year,
    String? subject,
    String? age,
  }) = _PersonBundle;

  factory PersonBundle.fromJson(Map<String, dynamic> json) =>
      _$PersonBundleFromJson(json);

  static PersonBundle fromJsonString(String data) =>
      PersonBundle.fromJson(json.decode(data));
}
