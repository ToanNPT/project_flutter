
import 'dart:convert';

import 'package:UdemyClone/models/LoginPayload.dart';
import 'package:UdemyClone/models/AuthUser.dart';
import 'package:http/http.dart';
import 'package:UdemyClone/ultis/ApiEndpoint.dart' as ApiConst;
class AuthenRepository {
  String userUrl = ApiConst.LOGIN_ENDPOINT;

  Future<AuthUser> login(LoginPayload payload) async {
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