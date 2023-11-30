class UserModel {
  final String firstname;
  final String lastname;
  final String email;
  final String telephone;
  final String avatar;
  final String rating;
  final String verified;

  UserModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.telephone,
    required this.avatar,
    required this.rating,
    required this.verified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      telephone: json['telephone'],
      avatar: json['avatar'],
      rating: json['rating'],
      verified: json['verified'],
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
    };
  }
}
