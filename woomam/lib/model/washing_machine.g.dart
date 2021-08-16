// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'washing_machine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WashingMachine _$WashingMachineFromJson(Map<String, dynamic> json) =>
    WashingMachine(
      arduinoState: _$enumDecode(_$ArduinoStateEnumMap, json['arduinoState']),
      phoneNumber: json['phoneNumber'] as String?,
      storeUID: json['storeUID'] as String,
      taskFrom: json['taskFrom'] == null
          ? null
          : DateTime.parse(json['taskFrom'] as String),
      taskTo: json['taskTo'] == null
          ? null
          : DateTime.parse(json['taskTo'] as String),
      bookedTime: json['bookedTime'] == null
          ? null
          : DateTime.parse(json['bookedTime'] as String),
      qrState: _$enumDecode(_$QRStateEnumMap, json['qrState']),
      washingMachineState: _$enumDecode(
          _$WashingMachineStateEnumMap, json['washingMachineState']),
      washingMachineUID: json['washingMachineUID'] as String,
    );

Map<String, dynamic> _$WashingMachineToJson(WashingMachine instance) =>
    <String, dynamic>{
      'storeUID': instance.storeUID,
      'washingMachineUID': instance.washingMachineUID,
      'phoneNumber': instance.phoneNumber,
      'taskFrom': instance.taskFrom?.toIso8601String(),
      'taskTo': instance.taskTo?.toIso8601String(),
      'bookedTime': instance.bookedTime?.toIso8601String(),
      'qrState': _$QRStateEnumMap[instance.qrState],
      'arduinoState': _$ArduinoStateEnumMap[instance.arduinoState],
      'washingMachineState':
          _$WashingMachineStateEnumMap[instance.washingMachineState],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$ArduinoStateEnumMap = {
  ArduinoState.opened: 'opened',
  ArduinoState.closed: 'closed',
};

const _$QRStateEnumMap = {
  QRState.unChecked: 'unChecked',
  QRState.verified: 'verified',
};

const _$WashingMachineStateEnumMap = {
  WashingMachineState.turnedOnOpened: 'turnedOnOpened',
  WashingMachineState.running: 'running',
  WashingMachineState.turnedOff: 'turnedOff',
};
