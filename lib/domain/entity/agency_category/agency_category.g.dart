// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agency_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgencyCategoryImpl _$$AgencyCategoryImplFromJson(Map<String, dynamic> json) =>
    _$AgencyCategoryImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      status: json['status'] as int?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      updateDate: json['updateDate'],
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$$AgencyCategoryImplToJson(
        _$AgencyCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'status': instance.status,
      'createdDate': instance.createdDate?.toIso8601String(),
      'updateDate': instance.updateDate,
      'image': instance.image,
      'quantity': instance.quantity,
    };
