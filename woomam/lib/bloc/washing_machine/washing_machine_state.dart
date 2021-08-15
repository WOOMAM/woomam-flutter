import 'package:equatable/equatable.dart';
import 'package:woomam/model/washing_machine.dart';

///
/// the main service screen will be using washing machine
///
/// the washing machine state will be composed of 5 different states
///
/// [WashingMachineEmpty]: no data is loaded in WashingMachine object
///
/// [WashingMachineError]: sth went wrong with WashingMachine data
/// need to check with storeUID, washingMachineUID and userUID or else
///
/// [WashingMachineLoading]: data is being fetched from the server
///
/// [WashingMachineNotVerified]: got data but *needs user verification to use*
///
/// [WashingMachineVerified]: got data and able to occur any event
abstract class WashingMachineState extends Equatable {}

/// [WashingMachineEmpty]: no data is loaded in WashingMachine object
///
/// `get` method returns []
class WashingMachineEmpty extends WashingMachineState {
  @override
  List<Object> get props => [];
}

/// [WashingMachineError]: sth went wrong with WashingMachine data
/// need to check with storeUID, washingMachineUID and userUID or else
///
/// `get` method returns [msg]
class WashingMachineError extends WashingMachineState {
  final String msg;
  WashingMachineError({required this.msg});
  @override
  List<Object> get props => [msg];
}

/// [WashingMachineLoading]: data is being fetched from the server
///
/// `get` method returns []
class WashingMachineLoading extends WashingMachineState {
  @override
  List<Object> get props => [];
}

/// [WashingMachineNotVerified]: got data but *needs user verification to use*
///
/// `get` method returns [washingMachine]
class WashingMachineNotVerified extends WashingMachineState {
  final WashingMachine washingMachine;
  WashingMachineNotVerified({required this.washingMachine});

  @override
  List<Object> get props => [washingMachine];
}

/// [WashingMachineVerified]: got data and able to occur any event
///
/// `get` method returns [washingMachine]
class WashingMachineVerified extends WashingMachineState {
  final WashingMachine washingMachine;
  WashingMachineVerified({required this.washingMachine});

  @override
  List<Object> get props => [washingMachine];
}
