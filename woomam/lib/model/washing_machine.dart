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

  double getPercentageOfProcess(DateTime currentTime) =>
      taskFrom != null && taskTo != null
          ? (taskTo!.toLocal().difference(currentTime).inSeconds /
              taskTo!.toLocal().difference(taskFrom!.toLocal()).inSeconds)
          : 0.0;

  /// get left time based on [bookedTime]
  ///
  /// returns `Positive` when its reserved
  /// or else returns `Negative` when its expired
  ///
  /// if the [bookedTime] is null, it returns `Duration 0`
  Duration getLeftDuration(DateTime currentTime) {
    if (bookedTime != null) {
      /// found that DateTime doesn't get current Local time.. when it subtracts
      final from = DateTime(
          currentTime.year,
          currentTime.month,
          currentTime.day,
          currentTime.hour,
          currentTime.minute,
          currentTime.second);
      final to = DateTime(bookedTime!.year, bookedTime!.month, bookedTime!.day,
          bookedTime!.hour, bookedTime!.minute, bookedTime!.second);
      log(bookedTime!.toIso8601String() + '\t' + currentTime.toIso8601String());
      return from.difference(to);
    }
    return const Duration(minutes: 0);
  }

  /// check the washing machine has reserved already
  /// based on current time
  bool isWashingMachineReserved(DateTime currentTime) {
    if (bookedTime != null) {
      final isInFiveMinutes = getLeftDuration(currentTime).isNegative;
      return isInFiveMinutes;
    }
    return false;
  }

  /// check process status
  bool isWaitingForUserVerification(DateTime currentTime) =>
      isWashingMachineReserved(currentTime) &&
      qrState == QRState.unchecked &&
      washingMachineState == WashingMachineRunningState.turnedOff &&
      arduinoState == ArduinoState.opened;

  bool isReadyForRunningWashingMachine() =>
      qrState == QRState.verified &&
      washingMachineState == WashingMachineRunningState.turnedOn &&
      arduinoState == ArduinoState.opened;

  bool isReadyForInitWashingMachine() =>
      qrState == QRState.verified &&
      // this is ideal version
      // washingMachineState == WashingMachineRunningState.turnedOff &&
      // arduinoState == ArduinoState.closed
      (taskTo != null && DateTime.now().isAfter(taskTo!.toLocal()));

  /// define model to have copy
  WashingMachine getRunningWashingMachineModel(DateTime from, DateTime to) =>
      WashingMachine(
        washingMachineState: WashingMachineRunningState.running,
        arduinoState: ArduinoState.closed,
        qrState: QRState.verified,
        phoneNumber: phoneNumber,
        taskFrom: from,
        taskTo: to,
        bookedTime: null,
        storeUID: storeUID,
        washingMachineUID: washingMachineUID,
      );

  WashingMachine getInitWashingMachineModel() => WashingMachine(
        washingMachineState: WashingMachineRunningState.turnedOff,
        arduinoState: ArduinoState.opened,
        qrState: QRState.unchecked,
        phoneNumber: phoneNumber,
        taskFrom: null,
        taskTo: null,
        bookedTime: null,
        storeUID: storeUID,
        washingMachineUID: washingMachineUID,
      );

  WashingMachine getVerifiedWashingMachineModel() => WashingMachine(
        washingMachineState: WashingMachineRunningState.turnedOn,
        arduinoState: ArduinoState.opened,
        qrState: QRState.verified,
        phoneNumber: phoneNumber,
        taskFrom: null,
        taskTo: null,
        bookedTime: null,
        storeUID: storeUID,
        washingMachineUID: washingMachineUID,
      );

  /// hanlde `JSON`
  factory WashingMachine.fromJson(Map<String, dynamic> json) =>
      _$WashingMachineFromJson(json);
  Map<String, dynamic> toJson() => _$WashingMachineToJson(this);
}
