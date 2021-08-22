/// set the URL end points here
class WoomamURL {
  final String _baseURL = 'http://localhost:3000/';

  /// get `baseURL`
  String get baseURL => _baseURL;

  /// user
  String get signUp => _baseURL + 'signup';
  String get signIn => _baseURL + 'signin';
  String get signOut => _baseURL + 'signin/destroy';

  /// washing machine
  String get reserve => _baseURL + 'wms/book';
  String get qrCheck => _baseURL + 'wms/qrcheck';
  String get runWashingMachine => _baseURL + 'wms/start';
  String get initWashingMachine => _baseURL + 'wms/initialize';

  
}
