import 'dart:convert';
import 'package:dio_http/dio_http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// import model
import 'package:woomam/model/model.dart';
import 'package:woomam/respository/header.dart';

/// import endpoint
import './end_point.dart';

/// [the Data layer]
///
/// which is relevant to user functions
/// will be managed with Firebase and main server(local)
///
class UserRepository {
  SharedPreferences prefs;

  UserRepository({required this.prefs});

  final ep = EndPoint();

  /// `POST`, [sign-up]
  /// the successful response returns the class of `User`
  Future<dynamic> signUpuser({required User applicant}) async {
    try {
      /// make request
      final url = Uri.parse(ep.signUp);

      /// wait for response
      final response = await http.post(url,
          headers: generateHeader(),
          body: jsonEncode(applicant.toJson()..remove('point')));
      final parsedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      final parsedResult = parsedResponse['result'];
      final parsedMessage = parsedResponse['message'];
      // final parsedData = parsedResponse['data']; // no use..

      /// check response
      assert(response.statusCode == 200 && parsedResult == true,
          'sign-up response was $parsedMessage');

      /// when the response's statusCode was `200`
      /// return with its body parsed
      return applicant;
    } catch (e) {
      return e.toString();
    }
  }

  /// `POST`, [sign-in]
  /// the successful response returns the class of `String` with token
  /// else the msg is returned starting with 'ERROR'
  Future<dynamic> signInUser(
      {required String userUID, required String phoneNumber}) async {
    try {
      /// make request
      final url = Uri.parse(ep.signIn);
      final requestBody = {"userUID": userUID, "phoneNumber": phoneNumber};

      final response = await http.post(url,
          headers: generateHeader(),
          body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        final token = jsonDecode(utf8.decode(response.bodyBytes))['token'];
        final result = await prefs.setString('token', token);
        return result;
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }

  /// `DELETE`, [sign-out]
  ///
  Future<bool> signOutUser({required String userToken}) async {
    /// make request
    final url = Uri.parse(ep.signOut);
    final requestBody = {"token": userToken};

    /// wait for response
    final response = await http.delete(url,
        headers: generateHeader(), body: jsonEncode(requestBody));

    /// check response
    assert(response.statusCode == 200,
        'sign-out response was ${response.statusCode}');

    /// returns true when the result was successful
    return true;
  }
}
