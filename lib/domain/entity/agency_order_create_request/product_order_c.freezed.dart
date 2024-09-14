// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_order_c.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProductOrderC _$ProductOrderCFromJson(Map<String, dynamic> json) {
  return _ProductOrderC.fromJson(json);
}

/// @nodoc
mixin _$ProductOrderC {
  int? get amount => throw _privateConstructorUsedError;
  String? get productPropertyId => throw _privateConstructorUsedError;
  int? get discountAmount => throw _privateConstructorUsedError;
  String? get discountCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProductOrderCCopyWith<ProductOrderC> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductOrderCCopyWith<$Res> {
  factory $ProductOrderCCopyWith(
          ProductOrderC value, $Res Function(ProductOrderC) then) =
      _$ProductOrderCCopyWithImpl<$Res, ProductOrderC>;
  @useResult
  $Res call(
      {int? amount,
      String? productPropertyId,
      int? discountAmount,
      String? discountCode});
}

/// @nodoc
class _$ProductOrderCCopyWithImpl<$Res, $Val extends ProductOrderC>
    implements $ProductOrderCCopyWith<$Res> {
  _$ProductOrderCCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? productPropertyId = freezed,
    Object? discountAmount = freezed,
    Object? discountCode = freezed,
  }) {
    return _then(_value.copyWith(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      productPropertyId: freezed == productPropertyId
          ? _value.productPropertyId
          : productPropertyId // ignore: cast_nullable_to_non_nullable
              as String?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      discountCode: freezed == discountCode
          ? _value.discountCode
          : discountCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductOrderCImplCopyWith<$Res>
    implements $ProductOrderCCopyWith<$Res> {
  factory _$$ProductOrderCImplCopyWith(
          _$ProductOrderCImpl value, $Res Function(_$ProductOrderCImpl) then) =
      __$$ProductOrderCImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? amount,
      String? productPropertyId,
      int? discountAmount,
      String? discountCode});
}

/// @nodoc
class __$$ProductOrderCImplCopyWithImpl<$Res>
    extends _$ProductOrderCCopyWithImpl<$Res, _$ProductOrderCImpl>
    implements _$$ProductOrderCImplCopyWith<$Res> {
  __$$ProductOrderCImplCopyWithImpl(
      _$ProductOrderCImpl _value, $Res Function(_$ProductOrderCImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = freezed,
    Object? productPropertyId = freezed,
    Object? discountAmount = freezed,
    Object? discountCode = freezed,
  }) {
    return _then(_$ProductOrderCImpl(
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      productPropertyId: freezed == productPropertyId
          ? _value.productPropertyId
          : productPropertyId // ignore: cast_nullable_to_non_nullable
              as String?,
      discountAmount: freezed == discountAmount
          ? _value.discountAmount
          : discountAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      discountCode: freezed == discountCode
          ? _value.discountCode
          : discountCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductOrderCImpl implements _ProductOrderC {
  _$ProductOrderCImpl(
      {this.amount,
      this.productPropertyId,
      this.discountAmount,
      this.discountCode});

  factory _$ProductOrderCImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductOrderCImplFromJson(json);

  @override
  final int? amount;
  @override
  final String? productPropertyId;
  @override
  final int? discountAmount;
  @override
  final String? discountCode;

  @override
  String toString() {
    return 'ProductOrderC(amount: $amount, productPropertyId: $productPropertyId, discountAmount: $discountAmount, discountCode: $discountCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductOrderCImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.productPropertyId, productPropertyId) ||
                other.productPropertyId == productPropertyId) &&
            (identical(other.discountAmount, discountAmount) ||
                other.discountAmount == discountAmount) &&
            (identical(other.discountCode, discountCode) ||
                other.discountCode == discountCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, amount, productPropertyId, discountAmount, discountCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductOrderCImplCopyWith<_$ProductOrderCImpl> get copyWith =>
      __$$ProductOrderCImplCopyWithImpl<_$ProductOrderCImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductOrderCImplToJson(
      this,
    );
  }
}

abstract class _ProductOrderC implements ProductOrderC {
  factory _ProductOrderC(
      {final int? amount,
      final String? productPropertyId,
      final int? discountAmount,
      final String? discountCode}) = _$ProductOrderCImpl;

  factory _ProductOrderC.fromJson(Map<String, dynamic> json) =
      _$ProductOrderCImpl.fromJson;

  @override
  int? get amount;
  @override
  String? get productPropertyId;
  @override
  int? get discountAmount;
  @override
  String? get discountCode;
  @override
  @JsonKey(ignore: true)
  _$$ProductOrderCImplCopyWith<_$ProductOrderCImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
