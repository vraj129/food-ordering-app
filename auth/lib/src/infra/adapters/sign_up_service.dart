import 'package:auth/auth.dart';

// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/infra/api/auth_api_contract.dart';

class SignUpService implements ISignUpService {
  final IAuthApi _authApi;

  SignUpService(this._authApi);

  @override
  Future<Result<Token>> signUp(String name, String email, String password) async {
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
