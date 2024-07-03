part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginLoadingState extends LoginState {
  @override
  List<Object?> get props => [];
}

class UserLoginState extends LoginState {
  final AuthEntity authEntity;
  const UserLoginState({
    required this.authEntity,
  }) : super();

  @override
  List<Object> get props => [authEntity];
}

class PhoneNumberState extends LoginState {
  final TelephoneEntity telephoneEntity;

  const PhoneNumberState({
    required this.telephoneEntity,
  });

  @override
  List<Object> get props => [telephoneEntity];
}

class VerifyOTPState extends LoginState {
  final OTPEntity otpEntity;

  const VerifyOTPState({required this.otpEntity});

  @override
  List<Object> get props => [otpEntity];
}

class CreateAccountState extends LoginState {
  final AuthEntity authEntity;

  const CreateAccountState({required this.authEntity});
  @override
  List<Object> get props => [authEntity];
}

class ErrorAuthState extends LoginState {
  final String message;
  const ErrorAuthState({required this.message});
  @override
  List<Object> get props => [message];
}
