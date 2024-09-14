// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_list_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CategoryListItem _$CategoryListItemFromJson(Map<String, dynamic> json) {
  return _CategoryListItem.fromJson(json);
}

/// @nodoc
mixin _$CategoryListItem {
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'categoryName')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'enable')
  bool? get enable => throw _privateConstructorUsedError;
  @JsonKey(name: 'error')
  dynamic get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoryListItemCopyWith<CategoryListItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryListItemCopyWith<$Res> {
  factory $CategoryListItemCopyWith(
          CategoryListItem value, $Res Function(CategoryListItem) then) =
      _$CategoryListItemCopyWithImpl<$Res, CategoryListItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'categoryName') String? categoryName,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'enable') bool? enable,
      @JsonKey(name: 'error') dynamic error});
}

/// @nodoc
class _$CategoryListItemCopyWithImpl<$Res, $Val extends CategoryListItem>
    implements $CategoryListItemCopyWith<$Res> {
  _$CategoryListItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? categoryName = freezed,
    Object? type = freezed,
    Object? enable = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      enable: freezed == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryListItemImplCopyWith<$Res>
    implements $CategoryListItemCopyWith<$Res> {
  factory _$$CategoryListItemImplCopyWith(_$CategoryListItemImpl value,
          $Res Function(_$CategoryListItemImpl) then) =
      __$$CategoryListItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') String? id,
      @JsonKey(name: 'categoryName') String? categoryName,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'enable') bool? enable,
      @JsonKey(name: 'error') dynamic error});
}

/// @nodoc
class __$$CategoryListItemImplCopyWithImpl<$Res>
    extends _$CategoryListItemCopyWithImpl<$Res, _$CategoryListItemImpl>
    implements _$$CategoryListItemImplCopyWith<$Res> {
  __$$CategoryListItemImplCopyWithImpl(_$CategoryListItemImpl _value,
      $Res Function(_$CategoryListItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? categoryName = freezed,
    Object? type = freezed,
    Object? enable = freezed,
    Object? error = freezed,
  }) {
    return _then(_$CategoryListItemImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryName: freezed == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      enable: freezed == enable
          ? _value.enable
          : enable // ignore: cast_nullable_to_non_nullable
              as bool?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryListItemImpl implements _CategoryListItem {
  const _$CategoryListItemImpl(
      {@JsonKey(name: 'id') this.id,
      @JsonKey(name: 'categoryName') this.categoryName,
      @JsonKey(name: 'type') this.type,
      @JsonKey(name: 'enable') this.enable,
      @JsonKey(name: 'error') this.error});

  factory _$CategoryListItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryListItemImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String? id;
  @override
  @JsonKey(name: 'categoryName')
  final String? categoryName;
  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'enable')
  final bool? enable;
  @override
  @JsonKey(name: 'error')
  final dynamic error;

  @override
  String toString() {
    return 'CategoryListItem(id: $id, categoryName: $categoryName, type: $type, enable: $enable, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryListItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.enable, enable) || other.enable == enable) &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, categoryName, type, enable,
      const DeepCollectionEquality().hash(error));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryListItemImplCopyWith<_$CategoryListItemImpl> get copyWith =>
      __$$CategoryListItemImplCopyWithImpl<_$CategoryListItemImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryListItemImplToJson(
      this,
    );
  }
}

abstract class _CategoryListItem implements CategoryListItem {
  const factory _CategoryListItem(
      {@JsonKey(name: 'id') final String? id,
      @JsonKey(name: 'categoryName') final String? categoryName,
      @JsonKey(name: 'type') final String? type,
      @JsonKey(name: 'enable') final bool? enable,
      @JsonKey(name: 'error') final dynamic error}) = _$CategoryListItemImpl;

  factory _CategoryListItem.fromJson(Map<String, dynamic> json) =
      _$CategoryListItemImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(name: 'categoryName')
  String? get categoryName;
  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'enable')
  bool? get enable;
  @override
  @JsonKey(name: 'error')
  dynamic get error;
  @override
  @JsonKey(ignore: true)
  _$$CategoryListItemImplCopyWith<_$CategoryListItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
