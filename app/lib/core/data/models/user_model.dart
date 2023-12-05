import 'package:taxialong/core/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.firstname,
      required super.lastname,
      required super.email,
      required super.telephone,
      required super.avatar,
      required super.rating,
      required super.verified,
      required super.role,
      required super.documentCount});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      telephone: json['telephone'],
      avatar: json['avatar'],
      rating: json['rating'],
      verified: json['verified'],
      role: json['role'],
      documentCount: json['documents_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "telephone": telephone,
      "avatar": avatar,
      "rating": rating,
      "verified": verified,
      "role": role,
      "documents_count": documentCount,
    };
  }
}
