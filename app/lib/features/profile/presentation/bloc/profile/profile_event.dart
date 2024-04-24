part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {}

class ProfileUpdateEvent extends ProfileEvent {
  final String firstname;
  final String lastname;
  final String telephone;
  final String email;

  ProfileUpdateEvent(
      {required this.firstname,
      required this.lastname,
      required this.telephone,
      required this.email});
  @override
  List<Object?> get props => [firstname, lastname, email, telephone];
}

class ProfileUpdateImageEvent extends ProfileEvent {
  final String path;

  ProfileUpdateImageEvent({required this.path});

  @override
  List<Object?> get props => throw [path];
}
