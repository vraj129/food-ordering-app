import 'package:auth/src/domain/token.dart';

// ignore: depend_on_referenced_packages
import 'package:async/async.dart';

abstract class IAuthService {
  Future<Result<Token>> signIn();

  Future<void> signOut();
}
