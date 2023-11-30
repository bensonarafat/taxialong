import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/profile/domain/entities/profile_entity.dart';
import 'package:taxialong/features/profile/domain/entities/profile_photo_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> updateProfile(params);
  Future<Either<Failure, ProfilePhototEntity>> updatePhoto(params);
}
