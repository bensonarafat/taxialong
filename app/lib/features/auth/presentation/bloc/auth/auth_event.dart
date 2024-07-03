part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthLogoutEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {}

class CheckAuth extends AuthEvent {}
