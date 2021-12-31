// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'near_shops_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NearShopsState extends NearShopsState {
  @override
  final AsyncField<BuiltList<RegionShops>>? shopsListField;
  @override
  final ShopListScreenMode? nearShopMode;
  @override
  final AsyncField<Location>? location;

  factory _$NearShopsState([void Function(NearShopsStateBuilder)? updates]) =>
      (new NearShopsStateBuilder()..update(updates)).build();

  _$NearShopsState._({this.shopsListField, this.nearShopMode, this.location})
      : super._();

  @override
  NearShopsState rebuild(void Function(NearShopsStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NearShopsStateBuilder toBuilder() =>
      new NearShopsStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NearShopsState &&
        shopsListField == other.shopsListField &&
        nearShopMode == other.nearShopMode &&
        location == other.location;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, shopsListField.hashCode), nearShopMode.hashCode),
        location.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NearShopsState')
          ..add('shopsListField', shopsListField)
          ..add('nearShopMode', nearShopMode)
          ..add('location', location))
        .toString();
  }
}

class NearShopsStateBuilder
    implements Builder<NearShopsState, NearShopsStateBuilder> {
  _$NearShopsState? _$v;

  AsyncFieldBuilder<BuiltList<RegionShops>>? _shopsListField;

  AsyncFieldBuilder<BuiltList<RegionShops>> get shopsListField =>
      _$this._shopsListField ??=
          new AsyncFieldBuilder<BuiltList<RegionShops>>();

  set shopsListField(
          AsyncFieldBuilder<BuiltList<RegionShops>>? shopsListField) =>
      _$this._shopsListField = shopsListField;

  ShopListScreenMode? _nearShopMode;

  ShopListScreenMode? get nearShopMode => _$this._nearShopMode;

  set nearShopMode(ShopListScreenMode? nearShopMode) =>
      _$this._nearShopMode = nearShopMode;

  AsyncFieldBuilder<Location>? _location;

  AsyncFieldBuilder<Location> get location =>
      _$this._location ??= new AsyncFieldBuilder<Location>();

  set location(AsyncFieldBuilder<Location>? location) =>
      _$this._location = location;

  NearShopsStateBuilder();

  NearShopsStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _shopsListField = $v.shopsListField?.toBuilder();
      _nearShopMode = $v.nearShopMode;
      _location = $v.location?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NearShopsState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NearShopsState;
  }

  @override
  void update(void Function(NearShopsStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NearShopsState build() {
    _$NearShopsState _$result;
    try {
      _$result = _$v ??
          new _$NearShopsState._(
              shopsListField: _shopsListField?.build(),
              nearShopMode: nearShopMode,
              location: _location?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'shopsListField';
        _shopsListField?.build();

        _$failedField = 'location';
        _location?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'NearShopsState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
