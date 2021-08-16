/// `solenoid` state
enum ArduinoState {
  opened,
  closed,
}

/// real washing machine
enum WashingMachineState {
  turnedOnOpened, // just turned on, not doing anything
  // turnedOnClosed, // turned on and user has put laundry
  running, // working
  turnedOff, // dead
}

/// user have to check itself twice in use
enum QRState {
  /// default - unchecked
  unChecked,
  verified,
}
