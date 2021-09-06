/// `solenoid` state
enum ArduinoState {
  opened,
  closed,
}

/// real washing machine
enum WashingMachineRunningState {
  turnedOn, // just turned on, not doing anything
  running, // working
  turnedOff, // dead - default
}

/// user have to check itself twice in use
enum QRState {
  /// default - unchecked
  unchecked,
  verified,
}
