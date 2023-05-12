class ChangePassword {
  String oldPwd;
  String newPwd;
  String confirmPwd;
  String username;

  ChangePassword({this.username, this.oldPwd, this.newPwd, this.confirmPwd});

  factory ChangePassword.fromJson(Map<String, dynamic> json) {
    return ChangePassword(
      username: json["username"],
      oldPwd: json["oldPwd"],
      newPwd: json["newPwd"],
      confirmPwd: json["confirmPwd"],
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'oldPwd': oldPwd,
        'newPwd': newPwd,
        'confirmPwd': confirmPwd
      };
}
