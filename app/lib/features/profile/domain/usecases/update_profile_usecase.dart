import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/profile/domain/entities/profile_entity.dart';
import 'package:taxialong/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase implements UseCase<ProfileEntity, ProfileParams> {
  ProfileRepository repository;

  UpdateProfileUseCase({required this.repository});
  @override
  Future<Either<Failure, ProfileEntity>> call(ProfileParams params) async {
    return await repository.updateProfile(params);
  }
}

class ProfileParams extends Equatable {
  final String firstname;
  final String lastname;
  final String email;
  final String telephone;

  const ProfileParams(
      {required this.firstname,
      required this.lastname,
      required this.email,
      required this.telephone});
  @override
  List<Object?> get props => [
        firstname,
        lastname,
        email,
        telephone,
      ];
}
