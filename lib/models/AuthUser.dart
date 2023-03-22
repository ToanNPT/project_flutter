class AuthUser {
  String token;
  String username;
  List<String> role;

  AuthUser({this.token, this.username, this.role});

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
        token: json["token"], username: json["username"], role: json["role"]);
  }

  Map<String, dynamic> toJson() =>
      {'username': username, 'token': token, 'role': role};
}
