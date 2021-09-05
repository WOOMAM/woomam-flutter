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

  /// the reservation takes 4 steps
  ///
  /// QR=QRState | WM=WashingMachineRunningState | AD=ArduinoState | T=_time
  ///
  /// 1) QR check
  /// condition: [currentTime(DateTime.now()) < bookedTime]
  /// before: < QR: unchecked | WM: Off | AD: O | T: O >
  /// after: < QR: verified | WM: On | AD: O | T: X >
  ///
  /// 2) Run Laundry
  /// before: < QR: verified | WM: On | AD: O | T: X >
  /// after: < QR: verified | WM: RUN | AD: X | T: X >
  ///
  /// 3) Laundry is Done
  /// before: < QR: verified | WM: RUN | AD: X | T: X >
  /// after: < QR: verified | WM: Off | AD: X | T: X >
  ///
  /// 4) Take out laudry
  /// before: < QR: verified | WM: Off | AD: X | T: X >
  /// after: < QR: unchecked | WM: Off | AD: O | T: X >
  @override
  Stream<WashingMachineState> mapEventToState(
      WashingMachineEvent event) async* {
    /// Get washing machine state
    /// step 3: check/get if the laundry is done
    if (event is GetStatsOfWashingMachineEvent) {
      yield* _mapGetStatsOfWashingMachineEventToState(event);
    } else if (event is GetReservationInformationEvent) {
      yield* _mapGetReservationInformationEventToState(event);
    }

    /// step 1: make reservation and verify user
    else if (event is ReserveWashingMachineEvent) {
      yield* _mapReserveWashingMachineEventToState(event);
    } else if (event is ConfirmUserToWashingMachineEvent) {
      yield* _mapConfirmUserToWashingMachineEventToState(event);
    }

    /// step 2: run washing machine
    else if (event is RunWashingMachineEvent) {
      yield* _mapRunWashingMachineEventToState(event);
    }

    /// step 4: take out the laundry from washing machine
    else if (event is InitWashingMachineEvent) {
      yield* _mapInitWashingMachineEventToState(event);
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
          bookedTime: DateTime.now()
              .toLocal()
              .add(const Duration(minutes: 5))
              .toIso8601String(),
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
      if (state is WashingMachineLoaded) {
        final prevState = state as WashingMachineLoaded;
        yield WashingMachineLoading();
        final response =
            await washingMachineRepository.verifyUserWithQRCodeOfWashingMachine(
          washingMachineUID: event.washingMachineUID,
          phoneNumber: event.currentUserPhoneNumber,
        );
        if (response) {
          final newWashingMachine = prevState.reservedWashingMachine!.getVerifiedWashingMachineModel();
          yield WashingMachineLoaded(
              washingMachines: prevState.washingMachines,
              reservedWashingMachine: newWashingMachine);
        }
      }
    } catch (e) {
      yield WashingMachineError(msg: e.toString());
    }
  }

  /// RunWashingMachineEvent
  Stream<WashingMachineState> _mapRunWashingMachineEventToState(
      RunWashingMachineEvent event) async* {
    try {
      if (state is WashingMachineLoaded) {
        final prevState = state as WashingMachineLoaded;
        yield WashingMachineLoading();
        final response = await washingMachineRepository.runWashingMachine(
            washingMachine: event.washingMachine);
        assert(response, 'running washing machine failed');
        final newWashingMachine = event.washingMachine;
        yield WashingMachineLoaded(
            washingMachines: prevState.washingMachines,
            reservedWashingMachine: newWashingMachine);
      }
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

  Stream<WashingMachineState> _mapInitWashingMachineEventToState(
      InitWashingMachineEvent event) async* {
    try {
      if (state is WashingMachineLoaded) {
        yield WashingMachineLoading();
        final response = await washingMachineRepository.initWashingMachine(
            washingMachineUID: event.washingMachine.washingMachineUID,
            phoneNumber: event.washingMachine.phoneNumber!);
        assert(response, 'could not init washing machine');
        yield WashingMachineLoaded(
            washingMachines: const [], reservedWashingMachine: null);
      }
    } catch (e) {
      yield WashingMachineError(msg: e.toString());
    }
  }
}
