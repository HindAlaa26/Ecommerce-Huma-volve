import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/error/failures.dart';
import 'package:ecommerce_app_huma_volve/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

import '../entities/auth_tokens_entity.dart';
import '../repositories/auth_repository.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginUseCase implements UseCase<AuthTokensEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, AuthTokensEntity>> call(LoginParams params) {
    return repository.login(email: params.email, password: params.password);
  }
}
