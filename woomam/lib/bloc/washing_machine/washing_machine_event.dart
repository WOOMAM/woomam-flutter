import 'package:equatable/equatable.dart';
import 'package:woomam/model/model.dart';

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
/// `get` method returns [storeUID]
class GetStatsOfWashingMachineEvent extends WashingMachineEvent {
  final String storeUID;

  GetStatsOfWashingMachineEvent({required this.storeUID});

  @override
  List<Object> get props => [storeUID];
}

/// [ReserveWashingMachineEvent]: reserve a specific washing machine with current user's phonenumber
///
/// `get` method returns [washingMachineUID, currentUserPhoneNumber]
class ReserveWashingMachineEvent extends WashingMachineEvent {
  final WashingMachine reservedWashingMachine;
  final String currentUserPhoneNumber;

  ReserveWashingMachineEvent(
      {required this.currentUserPhoneNumber,
      required this.reservedWashingMachine});

  @override
  List<Object> get props => [reservedWashingMachine, currentUserPhoneNumber];
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

class GetReservationInformationEvent extends WashingMachineEvent {
  final String userPhoneNumber;
  GetReservationInformationEvent({required this.userPhoneNumber});

  @override
  List<Object> get props => [userPhoneNumber];
}
