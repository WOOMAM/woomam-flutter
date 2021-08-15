import 'package:flutter_bloc/flutter_bloc.dart';

import 'washing_machine_event.dart';
import 'washing_machine_state.dart';

class WashingMachineBloc
    extends Bloc<WashingMachineEvent, WashingMachineState> {
  /// constructor
  WashingMachineBloc() : super(WashingMachineEmpty());

  @override
  Stream<WashingMachineState> mapEventToState(
      WashingMachineEvent event) async* {
    if (event is GetStatsOfWashingMachineEvent) {
      yield* _mapGetStatsOfWashingMachineEventToState(event);
    } else if (event is ReserveWashingMachineEvent) {
      yield* _mapReserveWashingMachineEventToState(event);
    } else if (event is ConfirmUserToWashingMachineEvent) {
      yield* _mapConfirmUserToWashingMachineEventToState(event);
    } else if (event is RunWashingMachineEvent) {
      yield* _mapRunWashingMachineEventToState(event);
    }
  }

  /// GetStatsOfWashingMachineEvent
  Stream<WashingMachineState> _mapGetStatsOfWashingMachineEventToState(
      GetStatsOfWashingMachineEvent event) async* {
    try {
      // TODO: implements to be done
    } catch (e) {
      yield WashingMachineError(msg: e.toString());
    }
  }

  /// ReserveWashingMachineEvent
  Stream<WashingMachineState> _mapReserveWashingMachineEventToState(
      ReserveWashingMachineEvent event) async* {
    try {
      // TODO: implements to be done
    } catch (e) {
      yield WashingMachineError(msg: e.toString());
    }
  }

  /// ConfirmUserToWashingMachineEvent
  Stream<WashingMachineState> _mapConfirmUserToWashingMachineEventToState(
      ConfirmUserToWashingMachineEvent event) async* {
    try {
      // TODO: implements to be done
    } catch (e) {
      yield WashingMachineError(msg: e.toString());
    }
  }

  /// RunWashingMachineEvent
  Stream<WashingMachineState> _mapRunWashingMachineEventToState(
      RunWashingMachineEvent event) async* {
    try {
      // TODO: implements to be done
    } catch (e) {
      yield WashingMachineError(msg: e.toString());
    }
  }
}
