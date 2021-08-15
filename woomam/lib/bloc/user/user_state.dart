import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:woomam/model/model.dart';

/// ## UserState
/// User will be signed-in with Firebase
/// state will be loaded into 5 different states
///
/// [UserEmpty] : none of user has logged-in via Firebase
///
/// [UserNeedInformation] : user has logged-in but don't have the information in our main server
///
/// [UserError] : sth went wrong with User's state
///
/// [UserLoading] : fetching data from main server
///
/// [UserLoaded] : everything fetched from main server
@immutable
abstract class UserState extends Equatable {}

/// ### UserEmpty
/// means the current User is Empty
///
/// `get` returns []
class UserEmpty extends UserState {
  @override
  List<Object> get props => [];
}

/// ### UserNeeedInformation
/// means the current User is not Empty but need the information
///
/// `get` returns []
class UserNeedInformation extends UserState {
  @override
  List<Object> get props => [];
}

/// ### UserError
/// means the current User has some Errors
///
/// `get` returns []
class UserError extends UserState {
  final String msg;
  UserError({required this.msg});
  @override
  List<Object> get props => [msg];
}

/// ### UserLoading
/// means the current User is being loaded from the server
///
/// `get` returns []
class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

/// ### UserLoaded
/// means the current User's data has successfully fetched from the server
///
/// with the `Getter` method, the current user's data will be fetched
///
/// `get` returns [User user]
class UserLoaded extends UserState {
  final User user;

  UserLoaded({required this.user});

  @override
  List<Object> get props => [user];
}
