class LoginPayload {
   String username;
   String password;

   LoginPayload( this.username,  this.password);

  factory LoginPayload.fromJson(Map<String, dynamic> json){
    return LoginPayload(
        json["username"],
        json["password"]
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
  };
}