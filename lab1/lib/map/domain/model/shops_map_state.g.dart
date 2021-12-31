// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shops_map_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ShopsMapState extends ShopsMapState {
  @override
  final AsyncField<bool>? progressState;
  @override
  final String? listUpdatedTimeStamp;
  @override
  final CameraPositionModel? cameraPositionModel;
  @override
  final ShopMarker? selectedShopMarker;
  @override
  final LatLng? userLocation;

  factory _$ShopsMapState([void Function(ShopsMapStateBuilder)? updates]) =>
      (new ShopsMapStateBuilder()..update(updates)).build();

  _$ShopsMapState._(
      {this.progressState,
      this.listUpdatedTimeStamp,
      this.cameraPositionModel,
      this.selectedShopMarker,
      this.userLocation})
      : super._();

  @override
  ShopsMapState rebuild(void Function(ShopsMapStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShopsMapStateBuilder toBuilder() => new ShopsMapStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ShopsMapState &&
        progressState == other.progressState &&
        listUpdatedTimeStamp == other.listUpdatedTimeStamp &&
        cameraPositionModel == other.cameraPositionModel &&
        selectedShopMarker == other.selectedShopMarker &&
        userLocation == other.userLocation;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc(0, progressState.hashCode),
                    listUpdatedTimeStamp.hashCode),
                cameraPositionModel.hashCode),
            selectedShopMarker.hashCode),
        userLocation.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ShopsMapState')
          ..add('progressState', progressState)
          ..add('listUpdatedTimeStamp', listUpdatedTimeStamp)
          ..add('cameraPositionModel', cameraPositionModel)
          ..add('selectedShopMarker', selectedShopMarker)
          ..add('userLocation', userLocation))
        .toString();
  }
}

class ShopsMapStateBuilder
    implements Builder<ShopsMapState, ShopsMapStateBuilder> {
  _$ShopsMapState? _$v;

  AsyncFieldBuilder<bool>? _progressState;

  AsyncFieldBuilder<bool> get progressState =>
      _$this._progressState ??= new AsyncFieldBuilder<bool>();

  set progressState(AsyncFieldBuilder<bool>? progressState) =>
      _$this._progressState = progressState;

  String? _listUpdatedTimeStamp;

  String? get listUpdatedTimeStamp => _$this._listUpdatedTimeStamp;

  set listUpdatedTimeStamp(String? listUpdatedTimeStamp) =>
      _$this._listUpdatedTimeStamp = listUpdatedTimeStamp;

  CameraPositionModel? _cameraPositionModel;

  CameraPositionModel? get cameraPositionModel => _$this._cameraPositionModel;

  set cameraPositionModel(CameraPositionModel? cameraPositionModel) =>
      _$this._cameraPositionModel = cameraPositionModel;

  ShopMarkerBuilder? _selectedShopMarker;

  ShopMarkerBuilder get selectedShopMarker =>
      _$this._selectedShopMarker ??= new ShopMarkerBuilder();

  set selectedShopMarker(ShopMarkerBuilder? selectedShopMarker) =>
      _$this._selectedShopMarker = selectedShopMarker;

  LatLng? _userLocation;

  LatLng? get userLocation => _$this._userLocation;

  set userLocation(LatLng? userLocation) => _$this._userLocation = userLocation;

  ShopsMapStateBuilder();

  ShopsMapStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _progressState = $v.progressState?.toBuilder();
      _listUpdatedTimeStamp = $v.listUpdatedTimeStamp;
      _cameraPositionModel = $v.cameraPositionModel;
      _selectedShopMarker = $v.selectedShopMarker?.toBuilder();
      _userLocation = $v.userLocation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ShopsMapState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ShopsMapState;
  }

  @override
  void update(void Function(ShopsMapStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ShopsMapState build() {
    _$ShopsMapState _$result;
    try {
      _$result = _$v ??
          new _$ShopsMapState._(
              progressState: _progressState?.build(),
              listUpdatedTimeStamp: listUpdatedTimeStamp,
              cameraPositionModel: cameraPositionModel,
              selectedShopMarker: _selectedShopMarker?.build(),
              userLocation: userLocation);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'progressState';
        _progressState?.build();

        _$failedField = 'selectedShopMarker';
        _selectedShopMarker?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ShopsMapState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
