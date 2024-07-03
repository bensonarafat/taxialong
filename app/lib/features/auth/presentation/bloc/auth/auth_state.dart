part of 'auth_bloc.dart';

@immutable
class AuthState extends Equatable {
  final AuthenticationStatus status;

  const AuthState(this.status);
  @override
  List<Object> get props => [status];
}
