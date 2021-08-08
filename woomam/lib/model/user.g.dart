// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userName: json['userName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      userUID: json['userUID'] as String,
      writtenDate: DateTime.parse(json['writtenDate'] as String),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userName': instance.userName,
      'phoneNumber': instance.phoneNumber,
      'userUID': instance.userUID,
      'writtenDate': instance.writtenDate.toIso8601String(),
    };
