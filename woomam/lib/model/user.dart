import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String userName; // entered by user
  final String phoneNumber; // firebase
  final String userUID; // QR CODE, firebase UID
  final DateTime writtenDate;

  User(
      {required this.userName,
      required this.phoneNumber,
      required this.userUID,
      required this.writtenDate});

  /// handle [JSON]
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
