import 'dart:developer';

import './enum.dart';

import 'package:json_annotation/json_annotation.dart';

part 'washing_machine.g.dart';

@JsonSerializable(explicitToJson: true)
class WashingMachine {
  final String storeUID;
  final String washingMachineUID;
  final String? phoneNumber;
  final DateTime? taskFrom;
  final DateTime? taskTo;
  final DateTime? bookedTime;
  final QRState qrState;
  final ArduinoState arduinoState;
  final WashingMachineRunningState? washingMachineState;

  WashingMachine(
      {required this.arduinoState,
      this.phoneNumber,
      required this.storeUID,
      this.taskFrom,
      this.taskTo,
      this.bookedTime,
      required this.qrState,
      required this.washingMachineState,
      required this.washingMachineUID});

  /// get left time based on current time
  int getPastTimeInMinutes() =>
      DateTime.now().difference(bookedTime!).inMinutes;

  /// check the washing machine has reserved already
  /// based on current time
  bool isWashingMachineReserved() {
    if (bookedTime != null) {
      final isInFiveMinutes = getPastTimeInMinutes() < 0;
      return isInFiveMinutes;
    }
    return true;
  }

  /// hanlde `JSON`
  factory WashingMachine.fromJson(Map<String, dynamic> json) =>
      _$WashingMachineFromJson(json);
  Map<String, dynamic> toJson() => _$WashingMachineToJson(this);
}
