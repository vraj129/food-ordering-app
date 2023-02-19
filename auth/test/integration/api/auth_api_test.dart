import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/domain/token.dart';
import 'package:auth/src/infra/api/auth_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  http.Client client;
  late AuthApi authApi;
  String baseUrl = "http://localhost:3000/";
  late Credential credential;
  setUp(() {
    authApi = AuthApi(
      client = http.Client(),
      baseUrl: baseUrl,
      signInEndPoint: "auth/signin",
      signUpEndPoint: "auth/signup",
      signOutEndPoint: "auth/signout",
      responseAuthValueKeyJson: "auth_token",
      serverErrorMessage: "Error",
      responseErrorMessageKeyJson: "error",
    );
  });
  credential = Credential(
    authType: AuthType.email,
    email: "test1@gmail.com",
    password: "123456",
  );

  group('signin', () {
    test('should return json web token when successful', () async {
      //arrange

      //act
      var res = await authApi.signIn(credential);

      //assert
      expect(res.asValue!.value, isNotEmpty);
    });
  });

  group('signout', () {
    test('should sign out user and return true', () async {
      //arrange
      var tokenStr = await authApi.signIn(credential);
      var token = Token(tokenValue: tokenStr.asValue!.value);

      //act
      var res = await authApi.signOut(token);

      //assert
      expect(res.asValue!.value, true);
    });
  });
}
