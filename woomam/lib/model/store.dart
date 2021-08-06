import 'package:json_annotation/json_annotation.dart';
import 'package:woomam/model/geolocation.dart';

part 'store.g.dart';

@JsonSerializable(explicitToJson: true)
class Store {
  final String storeUID;
  final String storeName;

  /// prefer using with `Location`, not just using with longitude and latitude
  final GeoLocation storeLocation;

  final DateTime createdOn;

  Store(
      {required this.createdOn,
      required this.storeLocation,
      required this.storeName,
      required this.storeUID});

  /// hanlde `JSON`
  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
  Map<String, dynamic> toJson() => _$StoreToJson(this);
}
