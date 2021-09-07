/// set the URL end points here
class EndPoint {
  final String _baseURL = 'http://35.213.84.65';

  /// each route's base
  final String signInRouter = '/signin';
  final String signUpRouter = '/signup';
  final String washingMachineRouter = '/wms';
  final String storeRouter = '/stores';
  final String userRouter = '/users';

  /// get `baseURL`
  String get baseURL => _baseURL;

  /// user
  String get signUp => _baseURL + signUpRouter;
  String get signIn => _baseURL + signInRouter;
  String get signOut => _baseURL + signInRouter + '/destroy';
  /// get reserved washing machine with user phone number
  String get reservedWashingMachine => _baseURL + userRouter + '/';

  /// washing machine
  String get allWashingMachines => _baseURL + washingMachineRouter + '/';

  /// returns statusCode `200` when it succeeded or else return only statusCode with `204`
  String get reserve => _baseURL + washingMachineRouter + '/book';

  /// returns statusCode `200` when it succeeded or else return only statusCode with `204`
  String get qrCheck => _baseURL + washingMachineRouter + '/qrcheck';

  /// returns statusCode `200` when it succeeded or else return only statusCode with `204`
  String get runWashingMachine => _baseURL + washingMachineRouter + '/start';

  /// returns statusCode `200` when it succeeded or else return only statusCode with `204`
  String get initWashingMachine =>
      _baseURL + washingMachineRouter + '/initialize';

  /// store
  String get allStores => _baseURL + storeRouter + '/';
}
