// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'person_bundle.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PersonBundle _$PersonBundleFromJson(Map<String, dynamic> json) {
  return _PersonBundle.fromJson(json);
}

/// @nodoc
class _$PersonBundleTearOff {
  const _$PersonBundleTearOff();

  _PersonBundle call(
      {String? firstName,
      String? lastName,
      String? direction,
      String? year,
      String? subject,
      String? age}) {
    return _PersonBundle(
      firstName: firstName,
      lastName: lastName,
      direction: direction,
      year: year,
      subject: subject,
      age: age,
    );
  }

  PersonBundle fromJson(Map<String, Object?> json) {
    return PersonBundle.fromJson(json);
  }
}

/// @nodoc
const $PersonBundle = _$PersonBundleTearOff();

/// @nodoc
mixin _$PersonBundle {
  String? get firstName => throw _privateConstructorUsedError;
  String? get lastName => throw _privateConstructorUsedError;
  String? get direction => throw _privateConstructorUsedError;
  String? get year => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;
  String? get age => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PersonBundleCopyWith<PersonBundle> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonBundleCopyWith<$Res> {
  factory $PersonBundleCopyWith(
          PersonBundle value, $Res Function(PersonBundle) then) =
      _$PersonBundleCopyWithImpl<$Res>;
  $Res call(
      {String? firstName,
      String? lastName,
      String? direction,
      String? year,
      String? subject,
      String? age});
}

/// @nodoc
class _$PersonBundleCopyWithImpl<$Res> implements $PersonBundleCopyWith<$Res> {
  _$PersonBundleCopyWithImpl(this._value, this._then);

  final PersonBundle _value;
  // ignore: unused_field
  final $Res Function(PersonBundle) _then;

  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? direction = freezed,
    Object? year = freezed,
    Object? subject = freezed,
    Object? age = freezed,
  }) {
    return _then(_value.copyWith(
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: direction == freezed
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String?,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      age: age == freezed
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$PersonBundleCopyWith<$Res>
    implements $PersonBundleCopyWith<$Res> {
  factory _$PersonBundleCopyWith(
          _PersonBundle value, $Res Function(_PersonBundle) then) =
      __$PersonBundleCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? firstName,
      String? lastName,
      String? direction,
      String? year,
      String? subject,
      String? age});
}

/// @nodoc
class __$PersonBundleCopyWithImpl<$Res> extends _$PersonBundleCopyWithImpl<$Res>
    implements _$PersonBundleCopyWith<$Res> {
  __$PersonBundleCopyWithImpl(
      _PersonBundle _value, $Res Function(_PersonBundle) _then)
      : super(_value, (v) => _then(v as _PersonBundle));

  @override
  _PersonBundle get _value => super._value as _PersonBundle;

  @override
  $Res call({
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? direction = freezed,
    Object? year = freezed,
    Object? subject = freezed,
    Object? age = freezed,
  }) {
    return _then(_PersonBundle(
      firstName: firstName == freezed
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String?,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String?,
      direction: direction == freezed
          ? _value.direction
          : direction // ignore: cast_nullable_to_non_nullable
              as String?,
      year: year == freezed
          ? _value.year
          : year // ignore: cast_nullable_to_non_nullable
              as String?,
      subject: subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
      age: age == freezed
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PersonBundle implements _PersonBundle {
  _$_PersonBundle(
      {this.firstName,
      this.lastName,
      this.direction,
      this.year,
      this.subject,
      this.age});

  factory _$_PersonBundle.fromJson(Map<String, dynamic> json) =>
      _$$_PersonBundleFromJson(json);

  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? direction;
  @override
  final String? year;
  @override
  final String? subject;
  @override
  final String? age;

  @override
  String toString() {
    return 'PersonBundle(firstName: $firstName, lastName: $lastName, direction: $direction, year: $year, subject: $subject, age: $age)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PersonBundle &&
            const DeepCollectionEquality().equals(other.firstName, firstName) &&
            const DeepCollectionEquality().equals(other.lastName, lastName) &&
            const DeepCollectionEquality().equals(other.direction, direction) &&
            const DeepCollectionEquality().equals(other.year, year) &&
            const DeepCollectionEquality().equals(other.subject, subject) &&
            const DeepCollectionEquality().equals(other.age, age));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(firstName),
      const DeepCollectionEquality().hash(lastName),
      const DeepCollectionEquality().hash(direction),
      const DeepCollectionEquality().hash(year),
      const DeepCollectionEquality().hash(subject),
      const DeepCollectionEquality().hash(age));

  @JsonKey(ignore: true)
  @override
  _$PersonBundleCopyWith<_PersonBundle> get copyWith =>
      __$PersonBundleCopyWithImpl<_PersonBundle>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PersonBundleToJson(this);
  }
}

abstract class _PersonBundle implements PersonBundle {
  factory _PersonBundle(
      {String? firstName,
      String? lastName,
      String? direction,
      String? year,
      String? subject,
      String? age}) = _$_PersonBundle;

  factory _PersonBundle.fromJson(Map<String, dynamic> json) =
      _$_PersonBundle.fromJson;

  @override
  String? get firstName;
  @override
  String? get lastName;
  @override
  String? get direction;
  @override
  String? get year;
  @override
  String? get subject;
  @override
  String? get age;
  @override
  @JsonKey(ignore: true)
  _$PersonBundleCopyWith<_PersonBundle> get copyWith =>
      throw _privateConstructorUsedError;
}
