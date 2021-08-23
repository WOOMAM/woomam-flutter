import 'package:json_annotation/json_annotation.dart';

part 'store.g.dart';

@JsonSerializable(explicitToJson: true)
class Store {
  final String storeUID;
  final String storeName;
  final double latitude;
  final double longitude;

  Store(
      {
      required this.latitude,
      required this.longitude,
      required this.storeName,
      required this.storeUID});

  /// hanlde `JSON`
  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
  Map<String, dynamic> toJson() => _$StoreToJson(this);
}
