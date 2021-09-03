import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:woomam/respository/header.dart';

/// import model
import '../model/model.dart';

/// import endpoint manager
import './end_point.dart';

/// [the Data layer]
///
/// the functions relevant with washing machine will be in this class
///
/// WashingMachineRespository will be usable after the user signed-in
class WashingMachineRepository {
  String token;

  /// set token when it constructs
  WashingMachineRepository({required this.token});

  /// set end point manager class
  final ep = EndPoint();

  /// [GET], get all washing machine states in specific store
  ///
  /// returns `List<WashingMachine>` when the request was successful
  Future<List<WashingMachine>> getAllWashingMachinesFromSpecificStore({
    required String storeUID,
  }) async {
    /// make `url` and `param`
    final url = Uri.parse(ep.allWashingMachines + storeUID);

    /// wait for response
    final response = await http.get(url, headers: generateHeader(token: token));

    /// parse the response
    final parsedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    final bool parsedResult = parsedResponse['result'];
    final String parsedMessage = parsedResponse['message'];

    /// check the response
    assert(response.statusCode == 200 && parsedResult,
        'getAllWashingMachineFromSpecificStore request received msg from server : $parsedMessage');

    /// parse the data and return
    final result = (parsedResponse['data'] as List<dynamic>)
        .map((e) => WashingMachine.fromJson(e))
        .toList();
    return result;
  }

  /// [POST], make reservation
  ///
  /// returns `true` when the request was successful
  Future<bool> reserveWashingMachine({
    required String washingMachineUID,
    required String bookedTime,
    required String phoneNumber,
  }) async {
    /// make `url` and `requestBody`
    final url = Uri.parse(ep.reserve);
    final requestBody = {
      "washingMachineUID": washingMachineUID,
      "bookedTime": bookedTime,
      "phoneNumber": phoneNumber
    };

    /// wait for response
    final response = await http.post(url,
        headers: generateHeader(token: token), body: jsonEncode(requestBody));

    /// parse the response
    final parsedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    final bool parsedResult = parsedResponse['result'];
    final String parsedMessage = parsedResponse['message'];

    /// check response
    assert(response.statusCode == 200 && parsedResult,
        'reserve request message from server was $parsedMessage');

    /// which will be `true`
    return parsedResult;
  }

  /// [POST], verify user's information
  ///
  /// returns `true` when the request was successful
  Future<bool> verifyUserWithQRCodeOfWashingMachine(
      {required String washingMachineUID, phoneNumber}) async {
    /// make `url` and `requestBody`
    final url = Uri.parse(ep.qrCheck);
    final requestBody = {
      "washingMachineUID": washingMachineUID,
      "phoneNumber": phoneNumber
    };

    /// wait for response
    final response = await http.post(url,
        headers: generateHeader(token: token), body: jsonEncode(requestBody));

    /// parse the response
    final parsedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    final bool parsedResult = parsedResponse['result'];
    final String parsedMessage = parsedResponse['message'];

    /// check response
    assert(response.statusCode == 200 && parsedResult,
        'qrcheck request message from server was $parsedMessage');

    /// which will be `true`
    return parsedResult;
  }

  /// [POST], run washing machine
  ///
  /// returns `true` when the request was successful
  Future<bool> runWashingMachine(
      {required WashingMachine washingMachine}) async {
    /// make `url`
    final url = Uri.parse(ep.runWashingMachine);

    /// wait for response
    final response = await http.post(url,
        headers: generateHeader(token: token),
        body: jsonEncode(washingMachine.toJson()));

    /// parse the response
    final parsedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    final bool parsedResult = parsedResponse['result'];
    final String parsedMessage = parsedResponse['message'];

    /// check response
    assert(response.statusCode == 200 && parsedResult,
        'Run Washing Machine request message from server was $parsedMessage');

    /// which will be `true`
    return parsedResult;
  }

  /// [POST], initialize washing machine
  ///
  /// returns `true` when the request was successful
  Future<bool> initWashingMachine(
      {required String washingMachineUID, phoneNumber}) async {
    /// make `url` and `requestBody`
    final url = Uri.parse(ep.initWashingMachine);
    final requestBody = {
      "washingMachineUID": washingMachineUID,
      "phoneNumber": phoneNumber
    };

    /// wait for response
    final response = await http.post(url,
        headers: generateHeader(token: token), body: jsonEncode(requestBody));

    /// parse the response
    final parsedResponse = jsonDecode(utf8.decode(response.bodyBytes));
    final bool parsedResult = parsedResponse['result'];
    final String parsedMessage = parsedResponse['message'];

    /// check response
    assert(response.statusCode == 200 && parsedResult,
        'init request message from server was $parsedMessage');

    /// which will be `true`
    return parsedResult;
  }

  Future<dynamic> getReservationInformation(
      {required String phoneNumber}) async {
    /// make request
    final url = Uri.parse(ep.reservedWashingMachine);
    final requetsBody = {"phoneNumber": phoneNumber};

    /// wait for response
    final response = await http.post(url,
        headers: generateHeader(token: token), body: jsonEncode(requetsBody));

    /// check the response
    if (response.statusCode == 200) {
      final parsedResult = jsonDecode(utf8.decode(response.bodyBytes));
      final parsedData = (parsedResult['data'] as List<dynamic>);
      return parsedData.map((e) => WashingMachine.fromJson(e)).toList()[0];
    } else if (response.statusCode == 204) {
      return null;
    } else {
      return 'the request was getReservationInformation client and the statusCode from server was ${response.statusCode}';
    }
  }
}
