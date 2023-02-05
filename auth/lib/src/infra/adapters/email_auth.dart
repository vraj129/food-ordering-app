// ignore: depend_on_referenced_packages, implementation_imports
import 'package:async/src/result/result.dart';
import 'package:auth/src/domain/auth_service_contract.dart';
import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/domain/signup_service_contract.dart';
import 'package:auth/src/domain/token.dart';
import 'package:auth/src/infra/api/auth_api_contract.dart';

class EmailAuth implements IAuthService, ISignUpService {
  final IAuthApi _authApi;
  Credential? _credential;

  EmailAuth(this._authApi);

  void credential({
    required String email,
    required String password,
  }) {
    _credential = Credential(
      authType: AuthType.email,
      email: email,
      password: password,
    );
  }

  @override
  Future<Result<Token>> signIn() async {
    assert(_credential != null);
    var result = await _authApi.signIn(_credential!);
    if (result.isError) return result.asError!;
    return Result.value(Token(tokenValue: result.asValue!.value));
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Result<Token>> signUp(
      String name, String email, String password) async {
    Credential credential = Credential(
      authType: AuthType.email,
      email: email,
      password: password,
    );
    var result = await _authApi.signUp(credential);
    if (result.isError) return result.asError!;
    return Result.value(Token(tokenValue: result.asValue!.value));
  }
}
