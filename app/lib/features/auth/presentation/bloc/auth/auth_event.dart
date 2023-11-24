part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckLoginEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {
  LogoutEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String telephone;

  LoginEvent({required this.telephone});

  @override
  List<Object> get props => [telephone];
}

class RegisterEvent extends AuthEvent {
  final String telephone;
  RegisterEvent({required this.telephone});
  @override
  List<Object> get props => [telephone];
}

class VerifyOTPEvent extends AuthEvent {
  final String otp;
  final String telephone;
  final String uuid;
  VerifyOTPEvent({
    required this.otp,
    required this.telephone,
    required this.uuid,
  });

  @override
  List<Object> get props => [otp];
}

class CreateAccountEvent extends AuthEvent {
  final String firstname;
  final String lastname;
  final String email;
  final String telephone;
  final String uuid;

  CreateAccountEvent({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.uuid,
    required this.telephone,
  });

  @override
  List<Object> get props => [firstname, lastname, email, uuid, telephone];
}
