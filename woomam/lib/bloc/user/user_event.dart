import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// ## UserEvent
/// the events that current User occurs will be listed here
///
/// [SignInEvent] : current user willing to sign-in via Firebase
///
/// [SignOutEvent] : current user willing to sign-out from Firebase and Woomam
///
/// [GetInformationEvent] : current user has signed-up before and willing to fetch data from the main server
///
/// TODO: [ServiceExitEvent] : when the current user is willing to exit out service
///
///
@immutable
abstract class UserEvent extends Equatable {}

/// ### SignInEvent
/// means the current User is willing to sign-in via Firebase
///
/// `get` method returns [String phoneNumber]
class SignInEvent extends UserEvent {
  final String phoneNumber;
  SignInEvent({required this.phoneNumber});
  @override
  List<Object> get props => [phoneNumber];
}

/// ### SignOutEvent
/// means the current User is willing to sign-out from Firebase and Woomam
///
/// `get` method returns [String phoneNumber]
class SignOutEvent extends UserEvent {
  final String phoneNumber;
  SignOutEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}

/// ### GetInformationEvent
/// means the current User has signed-up before and willing to fetch data from the main server
///
/// `get` method returns [String phoneNumber]
class GetInformationEvent extends UserEvent {
  final String phoneNumber;
  GetInformationEvent({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];
}
