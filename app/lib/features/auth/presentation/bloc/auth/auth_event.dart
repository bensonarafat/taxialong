part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckLoginEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {
  final LogoutEntity logoutEntity;

  LogoutEvent({required this.logoutEntity});

  @override
  List<Object> get props => [logoutEntity];
}

class LoginEvent extends AuthEvent {
  final LoginEntity loginEntity;

  LoginEvent({required this.loginEntity});

  @override
  List<Object> get props => [loginEntity];
}

class RegisterEvent extends AuthEvent {
  final RegisterEntity registerEntity;
  RegisterEvent({required this.registerEntity});
  @override
  List<Object> get props => [registerEntity];
}

class VerifyOTPEvent extends AuthEvent {
  final OTPEntity otpEntity;
  VerifyOTPEvent({required this.otpEntity});

  @override
  List<Object> get props => [otpEntity];
}

class CreateAccountEvent extends AuthEvent {
  final LoginEntity loginEntity;

  CreateAccountEvent({required this.loginEntity});

  @override
  List<Object> get props => [loginEntity];
}
