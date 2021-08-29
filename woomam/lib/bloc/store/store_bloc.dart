import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woomam/model/model.dart';

import 'package:woomam/respository/store_repository.dart';

import './store_event.dart';
import './store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  /// constructor
  StoreBloc({required this.storeRespository}) : super(StoreEmpty());

  final StoreRespository storeRespository;

  /// map events
  @override
  Stream<StoreState> mapEventToState(StoreEvent event) async* {
    if (event is GetStoresEvent) {
      yield* _mapGetStoresEventToState(event);
    }
  }

  Stream<StoreState> _mapGetStoresEventToState(GetStoresEvent event) async* {
    try {
      assert(state is StoreEmpty);
      yield StoreLoading();
      /// call the repository
      final response = await storeRespository.getAllStores();
      log(response.toString());
      yield StoresLoaded(stores: response);
    } catch (e) {
      yield StoreError(msg: e.toString());
    }
  }
}
