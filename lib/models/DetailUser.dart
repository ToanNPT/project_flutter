class DetailUser {
  String username;
  String role;
  String password;
  String fullname;
  String birthdate;
  String gender;
  String email;
  String phone;
  String avatar;

  DetailUser(
      this.username,
      this.role,
      this.password,
      this.fullname,
      this.birthdate,
      this.gender,
      this.email,
      this.phone,
      this.avatar
      );

  factory DetailUser.fromJson(Map<String, dynamic> json) {
    return DetailUser(
        json["username"],
        json["role"],
        json["password"],
        json["fullname"],
        json["birthdate"],
        json["gender"],
        json["email"],
        json["phone"],
        json["avatar"]
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'username': username,
        'role' : role,
        'password': password,
        'fullname':fullname,
        'birthdate': birthdate,
        'gender': gender,
        'email': email,
        'phone': phone,
        'avatar' : avatar
      };
}
