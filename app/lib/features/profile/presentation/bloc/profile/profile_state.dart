part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {}

class ProfileInitialState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileErrorState extends ProfileState {
  final String message;

  ProfileErrorState({required this.message});
  @override
  List<Object?> get props => [message];
}

class ProfileUpdateState extends ProfileState {
  final ProfileEntity profileEntity;

  ProfileUpdateState({required this.profileEntity});
  @override
  List<Object?> get props => [profileEntity];
}

class ProfilePhotoUpdateState extends ProfileState {
  final ProfilePhototEntity photoEntity;

  ProfilePhotoUpdateState({required this.photoEntity});
  @override
  List<Object?> get props => [photoEntity];
}
