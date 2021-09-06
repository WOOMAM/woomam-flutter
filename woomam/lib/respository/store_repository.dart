import 'dart:convert';

import 'package:http/http.dart' as http;
/// models
import '../model/model.dart';
/// endpoint and header
import './end_point.dart';
import './header.dart';

class StoreRespository {
  /// need token to use
  String token;
  /// set token by using constructor
  StoreRespository({required this.token});
  /// set the endpoint
  final ep = EndPoint();
  /// functions 
  Future<List<Store>> getAllStores() async {
    /// make url
    final url = Uri.parse(ep.allStores);
    /// wait for a response
    final response = await http.get(url, headers: generateHeader(token: token));
    /// parse result and return
    final parsedResult = jsonDecode(utf8.decode(response.bodyBytes));
    final parsedMessage = parsedResult['message'];
    final parsedData = parsedResult['data'] as List<dynamic>;
    /// check the response
    assert(response.statusCode == 200, 'getAllStores request received from server : $parsedMessage');
    final result = parsedData.map((e) => Store.fromJson(e)).toList();
    return result;
  }
}