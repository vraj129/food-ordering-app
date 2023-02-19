import 'package:auth/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_app/cache/local_store_contract.dart';
import 'package:food_ordering_app/models/User.dart';
import 'package:food_ordering_app/state_management/auth/auth_state.dart';

// ignore: depend_on_referenced_packages
import 'package:async/async.dart';

class AuthCubit extends Cubit<AuthState> {
  final ILocalStore localStore;

  AuthCubit(this.localStore) : super(InitialState());

  signIn(IAuthService iAuthService) async {
    _startLoading();
    final result = await iAuthService.signIn();
    _setResultOfAuthState(result);
  }

  void _setResultOfAuthState(Result<Token> result) {
    if (result.asError != null) {
      emit(
        ErrorState(
          message: result.asError!.error.toString(),
        ),
      );
    }
    emit(
      AuthSuccessState(
        token: result.asValue!.value,
      ),
    );
  }

  signOut(IAuthService authService) async {
    _startLoading();
    final token = await localStore.fetch();
    final res = await authService.signOut(token);
    if (res.asValue!.value) {
      localStore.delete(token);
      emit(SignOutSuccessState());
    } else {
      emit(ErrorState(message: "Error signing out"));
    }
  }

  signUp(ISignUpService iSignUpService, User user) async {
    _startLoading();
    final res = await iSignUpService.signUp(
      user.name,
      user.email,
      user.password,
    );
    _setResultOfAuthState(res);
  }

  void _startLoading() {
    emit(LoadingState());
  }
}
