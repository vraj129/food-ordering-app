import 'package:auth/src/domain/token.dart';

// ignore: depend_on_referenced_packages
import 'package:async/async.dart';

abstract class ISignUpService {
  Future<Result<Token>> signUp(
    String name,
    String email,
    String password,
  );
}
