import 'package:equatable/equatable.dart';

enum SignUpStatus { initial, loading, success, failure }

class SignUpState extends Equatable {
  final SignUpStatus status;
  final String? errorMessage;

  const SignUpState({this.status = SignUpStatus.initial, this.errorMessage});

  @override
  List<Object?> get props => [status, errorMessage];
}
