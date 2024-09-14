// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DefaultResponse<T> _$DefaultResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    DefaultResponse<T>(
      json['success'] as bool,
      json['statusCode'] as int,
      json['messages'] as List<dynamic>?,
      _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$DefaultResponseToJson<T>(
  DefaultResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'success': instance.success,
      'statusCode': instance.statusCode,
      'messages': instance.messages,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

DefaultPagingResponse<T> _$DefaultPagingResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    DefaultPagingResponse<T>(
      json['totalCount'] as int,
      _$nullableGenericFromJson(json['data'], fromJsonT),
    );

Map<String, dynamic> _$DefaultPagingResponseToJson<T>(
  DefaultPagingResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };
