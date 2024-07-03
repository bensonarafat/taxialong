part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class PhoneNumberEvent extends LoginEvent {
  final String telephone;

  PhoneNumberEvent({required this.telephone});

  @override
  List<Object> get props => [telephone];
}

class VerifyOTPEvent extends LoginEvent {
  final String otp;
  final String telephone;
  final String uuid;
  final String handler;
  VerifyOTPEvent({
    required this.otp,
    required this.telephone,
    required this.uuid,
    required this.handler,
  });

  @override
  List<Object> get props => [
        otp,
        telephone,
        uuid,
        handler,
      ];
}

class CreateAccountEvent extends LoginEvent {
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
