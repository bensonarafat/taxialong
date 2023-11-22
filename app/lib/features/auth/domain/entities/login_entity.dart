class LoginEntity {
  final String token;
  final int expiresIn;

  LoginEntity({
    required this.token,
    required this.expiresIn,
  });
}
