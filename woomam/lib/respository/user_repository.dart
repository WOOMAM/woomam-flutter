import 'dart:convert';
import 'package:http/http.dart' as http;

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
  final wmurl = WoomamURL();

  /// `POST`, [sign-up]
  /// the successful response returns the class of `User`
  Future<User> signUpuser({required User applicant}) async {
    /// make request
    final url = Uri.parse(wmurl.signUp);

    /// wait for response
    final response = await http.post(url,
        headers: generateHeader(),
        body: jsonEncode(applicant.toJson()..remove('point')));

    /// check response
    assert(response.statusCode == 200,
        'sign-up response was ${response.statusCode}');

    /// when the response's statusCode was `200`
    /// return with its body parsed
    return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  /// `POST`, [sign-in]
  /// the successful response returns the class of `User`
  Future<User> signInUser({required String userUID, phoneNumber}) async {
    /// make request
    final url = Uri.parse(wmurl.signIn);
    final requestBody = {"userUID": userUID, "phoneNumber": phoneNumber};

    /// wait for response
    final response = await http.post(url,
        headers: generateHeader(), body: jsonEncode(requestBody));

    /// check response
    assert(response.statusCode == 200,
        'sign-in response was ${response.statusCode}');

    /// when the response's statusCode was `200`
    /// return with its body parsed
    return User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  /// `DELETE`, [sign-out]
  ///
  Future<bool> signOutUser({required String userToken}) async {
    /// make request
    final url = Uri.parse(wmurl.signOut);
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
