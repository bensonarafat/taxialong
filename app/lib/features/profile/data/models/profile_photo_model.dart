import 'package:taxialong/features/profile/domain/entities/profile_photo_entity.dart';

class ProfilePhotoModel extends ProfilePhototEntity {
  ProfilePhotoModel({
    required super.status,
    required super.message,
  });

  factory ProfilePhotoModel.fromJson(Map<String, dynamic> json) {
    return ProfilePhotoModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
