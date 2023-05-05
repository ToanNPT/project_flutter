class RegisterPayload {
  String username;
  String password;
  String fullname;
  String birthdate;
  String gender;
  String email;
  String phone;

  RegisterPayload(
    this.username,
    this.password,
    this.fullname,
    this.birthdate,
    this.gender,
    this.email,
    this.phone
  );

  factory RegisterPayload.fromJson(Map<String, dynamic> json) {
    return RegisterPayload(
      json["username"],
      json["password"],
      json["fullname"],
      json["birthdate"],
      json["gender"],
      json["email"],
      json["phone"]
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'password': password,
        'fullname':fullname,
        'birthdate': birthdate,
        'gender': gender,
        'email': email,
        'phone': phone
      };
}
