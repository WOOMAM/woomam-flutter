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
/// [WashingMachineLoaded]: data is fetched
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

/// [WashingMachineLoaded]: fetched data
///
/// `get` method returns [washingMachines, reservedWashingMachine!]
class WashingMachineLoaded extends WashingMachineState {
  final List<WashingMachine> washingMachines;
  final WashingMachine? reservedWashingMachine;
  WashingMachineLoaded(
      {required this.washingMachines, required this.reservedWashingMachine});

  /// be aware of : second props can be null
  @override
  List<Object> get props => [washingMachines, reservedWashingMachine!];
}
