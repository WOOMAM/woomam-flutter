import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woomam/respository/washing_machine_repository.dart';

import 'washing_machine_event.dart';
import 'washing_machine_state.dart';

class WashingMachineBloc
    extends Bloc<WashingMachineEvent, WashingMachineState> {
  /// constructor
  WashingMachineBloc({required this.washingMachineRepository})
      : super(WashingMachineEmpty());

  final WashingMachineRepository washingMachineRepository;

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
    /// user can be either verified or not
    ///
    /// if not verified user emitted this event,
    /// the result state will be [WashingMachineNotVerified]
    ///
    /// else the state before and after will be from [WashingMachineVerified] to [WashingMachineVerified]
    try {
      /// init state or not verified
      if (state is WashingMachineNotVerified || state is WashingMachineEmpty) {
        yield WashingMachineLoading();
        final response = await washingMachineRepository
            .getAllWashingMachinesFromSpecificStore(storeUID: event.storeUID);
        yield WashingMachineNotVerified(
            washingMachines: response, reservedWashingMachine: null);
      }

      /// user has verified
      else if (state is WashingMachineVerified) {
        final prevState = state as WashingMachineVerified;
        yield WashingMachineLoading();
        final response = await washingMachineRepository
            .getAllWashingMachinesFromSpecificStore(storeUID: event.storeUID);
        yield WashingMachineVerified(
            washingMachines: response,
            reservedWashingMachine: prevState.reservedWashingMachine);
      }
    } catch (e) {
      yield WashingMachineError(msg: e.toString());
    }
  }

  /// ReserveWashingMachineEvent
  Stream<WashingMachineState> _mapReserveWashingMachineEventToState(
      ReserveWashingMachineEvent event) async* {
    try {
      /// must be emitted when its state is WashingMachineVerified
      if (state is WashingMachineNotVerified) {
        final prevState = state as WashingMachineNotVerified;
        yield WashingMachineLoading();
        final response = await washingMachineRepository.reserveWashingMachine(
          washingMachineUID: event.reservedWashingMachine.washingMachineUID,
          bookedTime:
              DateTime.now().add(const Duration(minutes: 5)).toIso8601String(),
          phoneNumber: event.currentUserPhoneNumber,
        );
        assert(response, 'the reservation failed');
        yield WashingMachineVerified(
          washingMachines: prevState.washingMachines,
          reservedWashingMachine: event.reservedWashingMachine,
        );
      }
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
