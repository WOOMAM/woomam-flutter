import 'package:json_annotation/json_annotation.dart';

part 'geolocation.g.dart';

@JsonSerializable()
class GeoLocation {
  final double latitude;
  final double longitude;

  GeoLocation({required this.latitude, required this.longitude});

  /// handle `JSON`
  factory GeoLocation.fromJson(Map<String, dynamic> json) =>
      _$GeoLocationFromJson(json);
  Map<String, dynamic> toJson() => _$GeoLocationToJson(this);
}
