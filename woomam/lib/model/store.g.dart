// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
      createdOn: DateTime.parse(json['createdOn'] as String),
      storeLocation:
          GeoLocation.fromJson(json['storeLocation'] as Map<String, dynamic>),
      storeName: json['storeName'] as String,
      storeUID: json['storeUID'] as String,
    );

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'storeUID': instance.storeUID,
      'storeName': instance.storeName,
      'storeLocation': instance.storeLocation.toJson(),
      'createdOn': instance.createdOn.toIso8601String(),
    };
