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
  final WashingMachineState washingMachineState;

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

  /// hanlde `JSON`
  factory WashingMachine.fromJson(Map<String, dynamic> json) =>
      _$WashingMachineFromJson(json);
  Map<String, dynamic> toJson() => _$WashingMachineToJson(this);
}
