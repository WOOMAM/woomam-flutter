import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// ## StoreEvent
/// every event in our service will be handled by [StoreEvent]
///
/// [GetStoresEvent]: show the list of stores and display with map
///
@immutable
abstract class StoreEvent extends Equatable {}

class GetStoresEvent extends StoreEvent {
  @override
  List<Object> get props => [];
}
