part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class LoginState extends AuthState {
  final AuthEntity authEntity;
  LoginState({
    required this.authEntity,
  });

  @override
  List<Object> get props => [authEntity];
}

class PhoneNumberState extends AuthState {
  final TelephoneEntity telephoneEntity;

  PhoneNumberState({
    required this.telephoneEntity,
  });

  @override
  List<Object> get props => [telephoneEntity];
}

class VerifyOTPState extends AuthState {
  final OTPEntity otpEntity;

  VerifyOTPState({required this.otpEntity});

  @override
  List<Object> get props => [otpEntity];
}

class CreateAccountState extends AuthState {
  final AuthEntity authEntity;

  CreateAccountState({required this.authEntity});
  @override
  List<Object> get props => [authEntity];
}

class LogoutState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String message;
  ErrorAuthState({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedState extends AuthState {}

class UnAuthenticatedState extends AuthState {}
