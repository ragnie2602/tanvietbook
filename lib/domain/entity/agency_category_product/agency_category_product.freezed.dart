// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'agency_category_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AgencyCategoryProduct _$AgencyCategoryProductFromJson(
    Map<String, dynamic> json) {
  return _AgencyCategoryProduct.fromJson(json);
}

/// @nodoc
mixin _$AgencyCategoryProduct {
  String? get name => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get agency => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AgencyCategoryProductCopyWith<AgencyCategoryProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AgencyCategoryProductCopyWith<$Res> {
  factory $AgencyCategoryProductCopyWith(AgencyCategoryProduct value,
          $Res Function(AgencyCategoryProduct) then) =
      _$AgencyCategoryProductCopyWithImpl<$Res, AgencyCategoryProduct>;
  @useResult
  $Res call(
      {String? name,
      String? image,
      String? link,
      String? description,
      String? agency});
}

/// @nodoc
class _$AgencyCategoryProductCopyWithImpl<$Res,
        $Val extends AgencyCategoryProduct>
    implements $AgencyCategoryProductCopyWith<$Res> {
  _$AgencyCategoryProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? image = freezed,
    Object? link = freezed,
    Object? description = freezed,
    Object? agency = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      agency: freezed == agency
          ? _value.agency
          : agency // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AgencyCategoryProductImplCopyWith<$Res>
    implements $AgencyCategoryProductCopyWith<$Res> {
  factory _$$AgencyCategoryProductImplCopyWith(
          _$AgencyCategoryProductImpl value,
          $Res Function(_$AgencyCategoryProductImpl) then) =
      __$$AgencyCategoryProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? image,
      String? link,
      String? description,
      String? agency});
}

/// @nodoc
class __$$AgencyCategoryProductImplCopyWithImpl<$Res>
    extends _$AgencyCategoryProductCopyWithImpl<$Res,
        _$AgencyCategoryProductImpl>
    implements _$$AgencyCategoryProductImplCopyWith<$Res> {
  __$$AgencyCategoryProductImplCopyWithImpl(_$AgencyCategoryProductImpl _value,
      $Res Function(_$AgencyCategoryProductImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? image = freezed,
    Object? link = freezed,
    Object? description = freezed,
    Object? agency = freezed,
  }) {
    return _then(_$AgencyCategoryProductImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      agency: freezed == agency
          ? _value.agency
          : agency // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AgencyCategoryProductImpl implements _AgencyCategoryProduct {
  _$AgencyCategoryProductImpl(
      {this.name, this.image, this.link, this.description, this.agency});

  factory _$AgencyCategoryProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$AgencyCategoryProductImplFromJson(json);

  @override
  final String? name;
  @override
  final String? image;
  @override
  final String? link;
  @override
  final String? description;
  @override
  final String? agency;

  @override
  String toString() {
    return 'AgencyCategoryProduct(name: $name, image: $image, link: $link, description: $description, agency: $agency)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AgencyCategoryProductImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.link, link) || other.link == link) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.agency, agency) || other.agency == agency));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, image, link, description, agency);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AgencyCategoryProductImplCopyWith<_$AgencyCategoryProductImpl>
      get copyWith => __$$AgencyCategoryProductImplCopyWithImpl<
          _$AgencyCategoryProductImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AgencyCategoryProductImplToJson(
      this,
    );
  }
}

abstract class _AgencyCategoryProduct implements AgencyCategoryProduct {
  factory _AgencyCategoryProduct(
      {final String? name,
      final String? image,
      final String? link,
      final String? description,
      final String? agency}) = _$AgencyCategoryProductImpl;

  factory _AgencyCategoryProduct.fromJson(Map<String, dynamic> json) =
      _$AgencyCategoryProductImpl.fromJson;

  @override
  String? get name;
  @override
  String? get image;
  @override
  String? get link;
  @override
  String? get description;
  @override
  String? get agency;
  @override
  @JsonKey(ignore: true)
  _$$AgencyCategoryProductImplCopyWith<_$AgencyCategoryProductImpl>
      get copyWith => throw _privateConstructorUsedError;
}
