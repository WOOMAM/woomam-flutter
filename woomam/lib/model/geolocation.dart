import 'package:json_annotation/json_annotation.dart';

part 'geolocation.g.dart';

@JsonSerializable()
class GeoLocation {
  final double latitude;  // 위도
  final double longitude; // 경도

  GeoLocation({required this.latitude, required this.longitude});

  /// handle `JSON`
  factory GeoLocation.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationFromJson(json);
  Map<String, dynamic> toJson() => _$GeoLocationToJson(this);
}
