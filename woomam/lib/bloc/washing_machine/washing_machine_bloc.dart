import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woomam/model/model.dart';
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
    } else if (event is GetReservationInformationEvent) {
      yield* _mapGetReservationInformationEventToState(event);
    }
  }

  /// GetStatsOfWashingMachineEvent
  ///
  /// all users can get data of the washing machines
  /// only when they don't have reservation
  Stream<WashingMachineState> _mapGetStatsOfWashingMachineEventToState(
      GetStatsOfWashingMachineEvent event) async* {
    try {
      if (state is WashingMachineLoaded) {
        final prevState = state as WashingMachineLoaded;
        yield WashingMachineLoading();
        final response = await washingMachineRepository
            .getAllWashingMachinesFromSpecificStore(storeUID: event.storeUID);
        yield WashingMachineLoaded(
            washingMachines: response,
            reservedWashingMachine: prevState.reservedWashingMachine);
      } else {
        yield WashingMachineLoading();
        final response = await washingMachineRepository
            .getAllWashingMachinesFromSpecificStore(storeUID: event.storeUID);
        yield WashingMachineLoaded(
            washingMachines: response, reservedWashingMachine: null);
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
      if (state is WashingMachineLoaded) {
        final prevState = state as WashingMachineLoaded;
        yield WashingMachineLoading();
        final response = await washingMachineRepository.reserveWashingMachine(
          washingMachineUID: event.reservedWashingMachine.washingMachineUID,
          bookedTime:
              DateTime.now().toLocal().add(const Duration(minutes: 5)).toIso8601String(),
          phoneNumber: event.currentUserPhoneNumber,
        );
        assert(response, 'the reservation failed');
        yield WashingMachineLoaded(
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

  Stream<WashingMachineState> _mapGetReservationInformationEventToState(
      GetReservationInformationEvent event) async* {
    try {
      yield WashingMachineLoading();
      final response = await washingMachineRepository.getReservationInformation(
          phoneNumber: event.userPhoneNumber);

      /// if the reservations exist
      if (response.runtimeType == WashingMachine) {
        /// the user don't need to display data of washing machines in reservation screen
        yield WashingMachineLoaded(
            washingMachines: const [], reservedWashingMachine: response);
      } else if (response == null) {
        yield WashingMachineLoaded(
            washingMachines: const [], reservedWashingMachine: null);
      }
    } catch (e) {
      yield WashingMachineError(msg: e.toString());
    }
  }
}
