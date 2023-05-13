
import 'dart:convert';

import 'package:UdemyClone/models/LoginPayload.dart';
import 'package:UdemyClone/models/AuthUser.dart';
import 'package:UdemyClone/repository/StorageRepository.dart';
import 'package:http/http.dart';
import 'package:UdemyClone/ultis/ApiEndpoint.dart' as ApiConst;
import 'package:UdemyClone/ultis/constants.dart' as Constants;

import '../models/ChangePassword.dart';
class AuthenRepository {
  String userUrl = ApiConst.LOGIN_ENDPOINT;
  StorageRepository storageRepository = new StorageRepository();

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

  Future<bool> changePass(ChangePassword changePassword) async {
    String token = await storageRepository.readSecureData(Constants.ACCESS_TOKEN_KEY);

    var body = changePassword.toJson();
    var b = jsonEncode(changePassword);
    Response response = await post(
        Uri.parse(ApiConst.CHANGE_PASS),
        headers: {
          "Authorization": "Bearer " + token,
          "Content-Type": "application/json"
        },
        body: json.encode(changePassword.toJson())
    );

    if (response.statusCode == 200) {
      final  json = jsonDecode(response.body);
      var res = json["data"];
      if(res == true){
        return true;
      }
      return false;
    } else {
      print("from repository: " + response.reasonPhrase);
      return false;
    }
  }




}