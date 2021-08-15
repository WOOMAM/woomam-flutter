import 'package:equatable/equatable.dart';

/// ## WashingMachineEvent
///
/// [ReserveWashingMachineEvent]: reserve the washing machine in the store with current User information
///
/// [ConfirmUserToWashingMachineEvent]: confirm the current user's information through QR code
///
/// [RunWashingMachineEvent]: run washing machine after the user has confirmed
///
/// [GetStatsOfWashingMachineEvent]: get stats of reserved washing machine

abstract class WashingMachineEvent extends Equatable {}

/// [GetWashingMachineEvent]: no use of listener since it has high-cost, fetch data with refresh
///
/// `get` method returns [washingMachineUID, reservedPhoneNumber]
class GetStatsOfWashingMachineEvent extends WashingMachineEvent {
  final String washingMachineUID;
  final String reservedPhoneNumber;

  GetStatsOfWashingMachineEvent(
      {required this.reservedPhoneNumber, required this.washingMachineUID});

  @override
  List<Object> get props => [washingMachineUID, reservedPhoneNumber];
}

/// [ReserveWashingMachineEvent]: reserve a specific washing machine with current user's phonenumber
///
/// `get` method returns [washingMachineUID, currentUserPhoneNumber]
class ReserveWashingMachineEvent extends WashingMachineEvent {
  final String washingMachineUID;
  final String currentUserPhoneNumber;

  ReserveWashingMachineEvent(
      {required this.currentUserPhoneNumber, required this.washingMachineUID});

  @override
  List<Object> get props => [washingMachineUID, currentUserPhoneNumber];
}

/// [ConfirmCurrentUserEvent]: current user need to confirm to verify self to use washing machine
///
/// `get` method returns [washingMachineUID, currentUserPhoneNumber]
class ConfirmUserToWashingMachineEvent extends WashingMachineEvent {
  final String currentUserPhoneNumber;
  final String washingMachineUID;

  ConfirmUserToWashingMachineEvent(
      {required this.currentUserPhoneNumber, required this.washingMachineUID});

  @override
  List<Object> get props => [washingMachineUID, currentUserPhoneNumber];
}

/// [RunWashingMachineEvent]: current user has confirmed and able to use to RUN
///
/// `get` method returns [washingMachineUID]
class RunWashingMachineEvent extends WashingMachineEvent {
  final String washingMachineUID;

  RunWashingMachineEvent({required this.washingMachineUID});

  @override
  List<Object> get props => [washingMachineUID];
}
