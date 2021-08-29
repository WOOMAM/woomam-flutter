// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Store _$StoreFromJson(Map<String, dynamic> json) => Store(
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      storeName: json['storeName'] as String,
      storeUID: json['storeUID'] as String,
    );

Map<String, dynamic> _$StoreToJson(Store instance) => <String, dynamic>{
      'storeUID': instance.storeUID,
      'storeName': instance.storeName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
