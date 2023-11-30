import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/profile/domain/entities/profile_entity.dart';
import 'package:taxialong/features/profile/domain/entities/profile_photo_entity.dart';
import 'package:taxialong/features/profile/domain/usecases/update_profile_image_usecase.dart';
import 'package:taxialong/features/profile/domain/usecases/update_profile_usecase.dart';

part 'profile_state.dart';
part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UpdateProfileUseCase updateProfileUseCase;
  UpdateProfileImageUseCase updateProfileImageUseCase;
  ProfileBloc({
    required this.updateProfileUseCase,
    required this.updateProfileImageUseCase,
  }) : super(ProfileInitialState()) {
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileUpdateEvent) {
        emit(ProfileLoadingState());

        final failureOrCreateAccount = await updateProfileUseCase(
          ProfileParams(
            firstname: event.firstname,
            lastname: event.lastname,
            email: event.email,
            telephone: event.telephone,
          ),
        );
        emit(failureOrCreateAccount.fold(
            (failure) =>
                ProfileErrorState(message: _mapFailureToMessage(failure)),
            (profileEntity) =>
                ProfileUpdateState(profileEntity: profileEntity)));
      } else if (event is ProfileUpdateImageEvent) {
        final failureOrCreateAccount = await updateProfileImageUseCase(
          ProfilePhotoParams(
            path: event.path,
          ),
        );
        emit(failureOrCreateAccount.fold(
            (failure) =>
                ProfileErrorState(message: _mapFailureToMessage(failure)),
            (photoEntity) =>
                ProfilePhotoUpdateState(photoEntity: photoEntity)));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'There was a server error!';
      case CacheFailure:
        return 'Cache Failure';
      case NetworkFailure:
        return 'Network error, check your internet connection';
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
