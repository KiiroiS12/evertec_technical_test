import 'package:equatable/equatable.dart';

enum SignupStatus { initial, loading, success, failure }

class SignupState extends Equatable {
  const SignupState({
    this.status = SignupStatus.initial,
    this.errorMessage,
  });

  final SignupStatus status;
  final String? errorMessage;

  bool get isLoading => status == SignupStatus.loading;
  bool get isSuccess => status == SignupStatus.success;
  bool get isFailure => status == SignupStatus.failure;

  SignupState copyWith({
    SignupStatus? status,
    String? errorMessage,
  }) {
    return SignupState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
