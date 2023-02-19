import 'dart:convert';

import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/infra/api/auth_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  MockClient? client;
  late AuthApi set;
  setUp(() {
    registerFallbackValue(Uri.parse('https://www.example.com/data'));
    client = MockClient();
    set = AuthApi(
      client!,
      baseUrl: 'http:baseUrl',
      signInEndPoint: '/auth/signin',
      signUpEndPoint: '/auth/signup',
      responseAuthValueKeyJson: 'auth_key',
      serverErrorMessage: 'Server error',
      responseErrorMessageKeyJson: 'message',
      signOutEndPoint: '/auth/signout',
    );
  });
  group('signin', () {
    var credential = Credential(
        authType: AuthType.email, email: 'email@email', password: "pass");
    test('should return error when the status code is not 200', () async {
      //arrange
      when(() => client?.post(any(), body: any(named: 'body')))
          .thenAnswer((realInvocation) async {
        return http.Response('{}', 404);
      });

      //act
      var result = await set.signIn(credential);

      //assert
      expect(result, isA<ErrorResult>());
    });
    test('should return error when the status code is 200 but malformed',
        () async {
      //arrange
      when(() => client?.post(any(), body: any(named: 'body')))
          .thenAnswer((realInvocation) async {
        String resBody = ''' 
            {
              "${set.responseErrorMessageKeyJson}" : "Error"
            }
            ''';
        return http.Response(resBody, 200);
      });

      //act
      var result = await set.signIn(credential);

      //assert
      expect(result, isA<ErrorResult>());
    });

    test('should return token string when successful', () async {
      var tokenStr = "Abbgs";
      //arrange
      when(() => client?.post(any(), body: any(named: 'body')))
          .thenAnswer((realInvocation) async {
        return http.Response(
            jsonEncode({set.responseAuthValueKeyJson: tokenStr}), 200);
      });

      //act
      var result = await set.signIn(credential);

      //assert
      expect(result.asValue!.value, tokenStr);
    });
  });
}
