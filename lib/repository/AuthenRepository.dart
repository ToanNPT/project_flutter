
import 'dart:convert';

import 'package:UdemyClone/models/LoginPayload.dart';
import 'package:UdemyClone/models/AuthUser.dart';
import 'package:http/http.dart';

class AuthenRepository {
  String userUrl = 'http://192.168.1.4:8080/api/v1/login';

  Future<AuthUser> login(LoginPayload payload) async {
    final p = payload.toJson();
    Response response = await post(
      Uri.parse(userUrl),
      body: jsonEncode(payload.toJson())
    );

    if (response.statusCode == 200) {
      final  json = jsonDecode(response.body);
      return AuthUser.fromJson(json["data"]);
    } else {
      print("from repository: " + response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }
}