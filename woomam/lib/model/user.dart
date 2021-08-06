import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String userName;
  final String phoneNumber;

  /// prefer createdOn, will be better
  final DateTime writtenDate;

  User(
      {required this.userName,
      required this.phoneNumber,
      required this.writtenDate});

  /// handle [JSON]
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
