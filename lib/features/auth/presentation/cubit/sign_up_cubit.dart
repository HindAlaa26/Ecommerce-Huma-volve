import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/sign_up_usecase.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpCubit(this._signUpUseCase) : super(const SignUpState());

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(const SignUpState(status: SignUpStatus.loading));

    final result = await _signUpUseCase(
      SignUpParams(name: name, email: email, password: password),
    );

    if (isClosed) return;

    result.fold(
      (failure) => emit(
        SignUpState(status: SignUpStatus.failure, errorMessage: failure.message),
      ),
      (_) => emit(const SignUpState(status: SignUpStatus.success)),
    );
  }
}
