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
  Future<WashingMachine> reserveWashingMachine(
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

    /// check response
    assert(response.statusCode == 200,
        'reserve statusCode was ${response.statusCode}');
    return WashingMachine.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  /// [POST], verify user's information
  Future<WashingMachine> verifyUserWithQRCodeOfWashingMachine(
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

    /// check response
    assert(response.statusCode == 200,
        'qrcheck statusCode was ${response.statusCode}');
    return WashingMachine.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  /// [POST], run washing machine
  Future<WashingMachine> runWashingMachine(
      {required WashingMachine washingMachine}) async {
    /// make `url`
    final url = Uri.parse(ep.runWashingMachine);

    /// wait for response
    final response = await http.post(url,
        headers: generateHeader(token: token),
        body: jsonEncode(washingMachine.toJson()));

    /// check response
    assert(response.statusCode == 200,
        'Run Washing Machine statusCode was ${response.statusCode}');
    return WashingMachine.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  /// [POST], initialize washing machine
  Future<WashingMachine> initWashingMachine(
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

    /// check response
    assert(response.statusCode == 200,
        'reserve statusCode was ${response.statusCode}');
    return WashingMachine.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }
}
