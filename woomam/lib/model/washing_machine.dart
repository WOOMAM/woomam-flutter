import './enum.dart';

import 'package:json_annotation/json_annotation.dart';

part 'washing_machine.g.dart';

@JsonSerializable(explicitToJson: true)
class WashingMachine {
  final String storeUID;
  final String washingMachineUID;
  final String? reservedPhoneNumber;
  final DateTime? taskFrom;
  final DateTime? taskTo;
  final ArduinoState arduinoState;
  final WashingMachineState washinMachineState;

  WashingMachine(
      {required this.arduinoState,
      this.reservedPhoneNumber,
      required this.storeUID,
      this.taskFrom,
      this.taskTo,
      required this.washinMachineState,
      required this.washingMachineUID});

  /// hanlde `JSON`
  factory WashingMachine.fromJson(Map<String, dynamic> json) =>
      _$WashingMachineFromJson(json);
  Map<String, dynamic> toJson() => _$WashingMachineToJson(this);
}
