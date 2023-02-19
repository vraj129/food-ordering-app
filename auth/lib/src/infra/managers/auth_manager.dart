import 'package:auth/auth.dart';
import 'package:auth/src/infra/adapters/email_auth.dart';
import 'package:auth/src/infra/adapters/google_auth.dart';
import 'package:auth/src/infra/api/auth_api_contract.dart';

class AuthManager {
  final IAuthApi _authApi;

  AuthManager(this._authApi);

  IAuthService get google => GoogleAuth(_authApi);

  IAuthService email({
    required String email,
    required String password,
  }) {
    final emailAuth = EmailAuth(_authApi);
    emailAuth.credential(
      email: email,
      password: password,
    );
    return emailAuth;
  }
}
