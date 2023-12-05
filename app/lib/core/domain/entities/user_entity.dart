class UserEntity {
  final String firstname;
  final String lastname;
  final String email;
  final String telephone;
  final String avatar;
  final String rating;
  final String verified;
  final String role;
  final String? documentCount;

  UserEntity(
      {required this.firstname,
      required this.lastname,
      required this.email,
      required this.telephone,
      required this.avatar,
      required this.rating,
      required this.verified,
      required this.role,
      required this.documentCount});
}
