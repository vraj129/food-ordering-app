import 'dart:convert';

import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/infra/api/auth_api_contract.dart';

// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:auth/src/infra/api/mapper.dart';
import 'package:http/http.dart' as http;

class AuthApi implements IAuthApi {
  ///Requires http object
  final http.Client _client;

  ///Base Url need for api calls
  String baseUrl;

  /// Url endpoint for signIn
  String signInEndPoint;

  /// Url endpoint for signUp
  String signUpEndPoint;

  /// Your json key value in which the token value be returned or could be taken from. for example
  /// {
  ///   'auth_key' : 'eysfhjsfkjadgfgsfghjsfhjg'
  /// }
  /// the 'auth_key' should be given in this variable
  String responseAuthValueKeyJson;

  ///What server message you want if the call returns other than status code of `200`
  String serverErrorMessage;

  /// If the status code is 200 but the value of `responseAuthValueKeyJson` is null and in the response
  /// itself there is a message what is the key value should be defined in this variable. for example
  /// {
  ///   'errorMessage' : Could not create user
  /// }
  /// the 'errorMessage' should be given in this variable.
  String responseErrorMessageKeyJson;

  AuthApi(
    this._client, {
    required this.baseUrl,
    required this.signInEndPoint,
    required this.signUpEndPoint,
    required this.responseAuthValueKeyJson,
    required this.serverErrorMessage,
    required this.responseErrorMessageKeyJson,
  });

  @override
  Future<Result<String>> signIn(Credential credential) async {
    var url = baseUrl + signInEndPoint;
    return await _postCredential(url, credential);
  }

  @override
  Future<Result<String>> signUp(Credential credential) async {
    var url = baseUrl + signUpEndPoint;
    return await _postCredential(url, credential);
  }

  Future<Result<String>> _postCredential(
    String url,
    Credential credential,
  ) async {
    var response = await _client.post(
      Uri.parse(url),
      body: Mapper.toJson(credential),
    );
    if (response.statusCode != 200) return Result.error(serverErrorMessage);
    var json = jsonDecode(response.body);
    return json[responseAuthValueKeyJson] != null
        ? Result.value(json[responseAuthValueKeyJson])
        : Result.error(json[responseErrorMessageKeyJson]);
  }
}
