// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'shops_search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ShopsSearchStateTearOff {
  const _$ShopsSearchStateTearOff();

  _ShopsSearchState call(
      {String? query,
      AsyncSnapshot<List<Shop>> shopsField = const AsyncSnapshot.nothing()}) {
    return _ShopsSearchState(
      query: query,
      shopsField: shopsField,
    );
  }
}

/// @nodoc
const $ShopsSearchState = _$ShopsSearchStateTearOff();

/// @nodoc
mixin _$ShopsSearchState {
  String? get query => throw _privateConstructorUsedError;

  AsyncSnapshot<List<Shop>> get shopsField =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShopsSearchStateCopyWith<ShopsSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopsSearchStateCopyWith<$Res> {
  factory $ShopsSearchStateCopyWith(
          ShopsSearchState value, $Res Function(ShopsSearchState) then) =
      _$ShopsSearchStateCopyWithImpl<$Res>;

  $Res call({String? query, AsyncSnapshot<List<Shop>> shopsField});
}

/// @nodoc
class _$ShopsSearchStateCopyWithImpl<$Res>
    implements $ShopsSearchStateCopyWith<$Res> {
  _$ShopsSearchStateCopyWithImpl(this._value, this._then);

  final ShopsSearchState _value;

  // ignore: unused_field
  final $Res Function(ShopsSearchState) _then;

  @override
  $Res call({
    Object? query = freezed,
    Object? shopsField = freezed,
  }) {
    return _then(_value.copyWith(
      query: query == freezed
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
      shopsField: shopsField == freezed
          ? _value.shopsField
          : shopsField // ignore: cast_nullable_to_non_nullable
              as AsyncSnapshot<List<Shop>>,
    ));
  }
}

/// @nodoc
abstract class _$ShopsSearchStateCopyWith<$Res>
    implements $ShopsSearchStateCopyWith<$Res> {
  factory _$ShopsSearchStateCopyWith(
          _ShopsSearchState value, $Res Function(_ShopsSearchState) then) =
      __$ShopsSearchStateCopyWithImpl<$Res>;

  @override
  $Res call({String? query, AsyncSnapshot<List<Shop>> shopsField});
}

/// @nodoc
class __$ShopsSearchStateCopyWithImpl<$Res>
    extends _$ShopsSearchStateCopyWithImpl<$Res>
    implements _$ShopsSearchStateCopyWith<$Res> {
  __$ShopsSearchStateCopyWithImpl(
      _ShopsSearchState _value, $Res Function(_ShopsSearchState) _then)
      : super(_value, (v) => _then(v as _ShopsSearchState));

  @override
  _ShopsSearchState get _value => super._value as _ShopsSearchState;

  @override
  $Res call({
    Object? query = freezed,
    Object? shopsField = freezed,
  }) {
    return _then(_ShopsSearchState(
      query: query == freezed
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String?,
      shopsField: shopsField == freezed
          ? _value.shopsField
          : shopsField // ignore: cast_nullable_to_non_nullable
              as AsyncSnapshot<List<Shop>>,
    ));
  }
}

/// @nodoc

class _$_ShopsSearchState implements _ShopsSearchState {
  const _$_ShopsSearchState(
      {this.query, this.shopsField = const AsyncSnapshot.nothing()});

  @override
  final String? query;
  @JsonKey(defaultValue: const AsyncSnapshot.nothing())
  @override
  final AsyncSnapshot<List<Shop>> shopsField;

  @override
  String toString() {
    return 'ShopsSearchState(query: $query, shopsField: $shopsField)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ShopsSearchState &&
            (identical(other.query, query) ||
                const DeepCollectionEquality().equals(other.query, query)) &&
            (identical(other.shopsField, shopsField) ||
                const DeepCollectionEquality()
                    .equals(other.shopsField, shopsField)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(query) ^
      const DeepCollectionEquality().hash(shopsField);

  @JsonKey(ignore: true)
  @override
  _$ShopsSearchStateCopyWith<_ShopsSearchState> get copyWith =>
      __$ShopsSearchStateCopyWithImpl<_ShopsSearchState>(this, _$identity);
}

abstract class _ShopsSearchState implements ShopsSearchState {
  const factory _ShopsSearchState(
      {String? query,
      AsyncSnapshot<List<Shop>> shopsField}) = _$_ShopsSearchState;

  @override
  String? get query => throw _privateConstructorUsedError;

  @override
  AsyncSnapshot<List<Shop>> get shopsField =>
      throw _privateConstructorUsedError;

  @override
  @JsonKey(ignore: true)
  _$ShopsSearchStateCopyWith<_ShopsSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}
