import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:woomam/model/model.dart';

@immutable
abstract class StoreState extends Equatable {}

class StoreEmpty extends StoreState {
  @override
  List<Object> get props => [];
}

class StoreLoading extends StoreState {
  @override
  List<Object> get props => [];
}

class StoreError extends StoreState {
  final String msg;
  StoreError({required this.msg});
  @override
  List<Object> get props => [msg];
}

class StoresLoaded extends StoreState {
  final List<Store> stores;
  StoresLoaded({required this.stores});
  @override
  List<Object> get props => [stores];
}
