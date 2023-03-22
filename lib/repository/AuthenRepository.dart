
import 'dart:convert';

import 'package:UdemyClone/models/LoginPayload.dart';
import 'package:UdemyClone/models/AuthUser.dart';
import 'package:http/http.dart';

class AuthenRepository {
  String userUrl = 'http://localhost:8080/login';

  Future<AuthUser> login(LoginPayload payload) async {
    Response response = await post(
      Uri.parse(userUrl),
      body: payload.toJson()
    );

    if (response.statusCode == 200) {
      final  json = jsonDecode(response.body);
      return AuthUser.fromJson(json);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}