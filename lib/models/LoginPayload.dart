class LoginPayload {
  final String username;
  final String password;

  LoginPayload({this.username, this.password});

  factory LoginPayload.fromJson(Map<String, dynamic> json){
    return LoginPayload(
        username: json["username"],
        password: json["password"]
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };
}