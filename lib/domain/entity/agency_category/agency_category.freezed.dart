// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agency_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AgencyCategory _$AgencyCategoryFromJson(Map<String, dynamic> json) {
  return _AgencyCategory.fromJson(json);
}

/// @nodoc
mixin _$AgencyCategory {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;
  DateTime? get createdDate => throw _privateConstructorUsedError;
  dynamic get updateDate => throw _privateConstructorUsedError;
  List<String>? get image => throw _privateConstructorUsedError;
  int? get quantity => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgencyCategoryCopyWith<AgencyCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgencyCategoryCopyWith<$Res> {
  factory $AgencyCategoryCopyWith(
          AgencyCategory value, $Res Function(AgencyCategory) then) =
      _$AgencyCategoryCopyWithImpl<$Res, AgencyCategory>;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? description,
      int? status,
      DateTime? createdDate,
      dynamic updateDate,
      List<String>? image,
      int? quantity});
}

/// @nodoc
class _$AgencyCategoryCopyWithImpl<$Res, $Val extends AgencyCategory>
    implements $AgencyCategoryCopyWith<$Res> {
  _$AgencyCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? status = freezed,
    Object? createdDate = freezed,
    Object? updateDate = freezed,
    Object? image = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updateDate: freezed == updateDate
          ? _value.updateDate
          : updateDate // ignore: cast_nullable_to_non_nullable
              as dynamic,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgencyCategoryImplCopyWith<$Res>
    implements $AgencyCategoryCopyWith<$Res> {
  factory _$$AgencyCategoryImplCopyWith(_$AgencyCategoryImpl value,
          $Res Function(_$AgencyCategoryImpl) then) =
      __$$AgencyCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? description,
      int? status,
      DateTime? createdDate,
      dynamic updateDate,
      List<String>? image,
      int? quantity});
}

/// @nodoc
class __$$AgencyCategoryImplCopyWithImpl<$Res>
    extends _$AgencyCategoryCopyWithImpl<$Res, _$AgencyCategoryImpl>
    implements _$$AgencyCategoryImplCopyWith<$Res> {
  __$$AgencyCategoryImplCopyWithImpl(
      _$AgencyCategoryImpl _value, $Res Function(_$AgencyCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? status = freezed,
    Object? createdDate = freezed,
    Object? updateDate = freezed,
    Object? image = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_$AgencyCategoryImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
      createdDate: freezed == createdDate
          ? _value.createdDate
          : createdDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updateDate: freezed == updateDate
          ? _value.updateDate
          : updateDate // ignore: cast_nullable_to_non_nullable
              as dynamic,
      image: freezed == image
          ? _value._image
          : image // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgencyCategoryImpl implements _AgencyCategory {
  _$AgencyCategoryImpl(
      {this.id,
      this.name,
      this.description,
      this.status,
      this.createdDate,
      this.updateDate,
      final List<String>? image,
      this.quantity})
      : _image = image;

  factory _$AgencyCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgencyCategoryImplFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final int? status;
  @override
  final DateTime? createdDate;
  @override
  final dynamic updateDate;
  final List<String>? _image;
  @override
  List<String>? get image {
    final value = _image;
    if (value == null) return null;
    if (_image is EqualUnmodifiableListView) return _image;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? quantity;

  @override
  String toString() {
    return 'AgencyCategory(id: $id, name: $name, description: $description, status: $status, createdDate: $createdDate, updateDate: $updateDate, image: $image, quantity: $quantity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgencyCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdDate, createdDate) ||
                other.createdDate == createdDate) &&
            const DeepCollectionEquality()
                .equals(other.updateDate, updateDate) &&
            const DeepCollectionEquality().equals(other._image, _image) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      description,
      status,
      createdDate,
      const DeepCollectionEquality().hash(updateDate),
      const DeepCollectionEquality().hash(_image),
      quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgencyCategoryImplCopyWith<_$AgencyCategoryImpl> get copyWith =>
      __$$AgencyCategoryImplCopyWithImpl<_$AgencyCategoryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgencyCategoryImplToJson(
      this,
    );
  }
}

abstract class _AgencyCategory implements AgencyCategory {
  factory _AgencyCategory(
      {final String? id,
      final String? name,
      final String? description,
      final int? status,
      final DateTime? createdDate,
      final dynamic updateDate,
      final List<String>? image,
      final int? quantity}) = _$AgencyCategoryImpl;

  factory _AgencyCategory.fromJson(Map<String, dynamic> json) =
      _$AgencyCategoryImpl.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get description;
  @override
  int? get status;
  @override
  DateTime? get createdDate;
  @override
  dynamic get updateDate;
  @override
  List<String>? get image;
  @override
  int? get quantity;
  @override
  @JsonKey(ignore: true)
  _$$AgencyCategoryImplCopyWith<_$AgencyCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
