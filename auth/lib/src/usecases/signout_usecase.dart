import 'package:auth/src/domain/auth_service_contract.dart';
import 'package:auth/src/domain/token.dart';

// ignore: depend_on_referenced_packages
import 'package:async/async.dart';

class SignOutUseCase {
  final IAuthService iAuthService;

  SignOutUseCase({required this.iAuthService});

  Future<Result<bool>> execute(Token token) async {
    return await iAuthService.signOut(token);
  }
}
