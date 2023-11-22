part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class LoginState extends AuthState {}

class RegisterState extends AuthState {}

class VerifyOTPState extends AuthState {}

class CreateAccountState extends AuthState {}

class LogoutState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String message;
  ErrorAuthState({required this.message});
  @override
  List<Object> get props => [message];
}

class AuthenticatedState extends AuthState {}

class UnAuthenticatedState extends AuthState {}
