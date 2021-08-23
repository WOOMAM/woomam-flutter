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

  /// [POST], make reservation
  ///
  /// returns `true` when the request was successful
  Future<bool> reserveWashingMachine(
      {required String washingMachineUID, bookedTime, phoneNumber}) async {
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
}
