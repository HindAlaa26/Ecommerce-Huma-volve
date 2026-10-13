import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_usecase.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(const LoginState());

  Future<void> login({required String email, required String password}) async {
    emit(const LoginState(status: LoginStatus.loading));

    final result = await _loginUseCase(
      LoginParams(email: email, password: password),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        LoginState(status: LoginStatus.failure, errorMessage: failure.message),
      ),
      (_) => emit(const LoginState(status: LoginStatus.success)),
    );
  }
}
