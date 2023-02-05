class Credential {
  final AuthType authType;
  final String? name;
  final String email;
  final String? password;

  Credential({
    required this.authType,
    this.name,
    required this.email,
    this.password,
  });
}

enum AuthType { email, google }
