
import 'dart:convert';

import 'package:UdemyClone/models/DetailUser.dart';
import 'package:UdemyClone/models/LoginPayload.dart';
import 'package:UdemyClone/models/AuthUser.dart';
import 'package:http/http.dart';
import 'package:UdemyClone/ultis/ApiEndpoint.dart' as ApiConst;
import 'package:UdemyClone/ultis/constants.dart' as Constants;

import 'StorageRepository.dart';
class DetailUserRepository {
  StorageRepository storageRepository;
  String userUrl = ApiConst.GET_DETAIL_USER;

  DetailUserRepository() {
    this.storageRepository = new StorageRepository();
  }

  Future<DetailUser> getDetail() async {
    String username = await storageRepository.readSecureData(Constants.USERNAME);
    Response response = await get(
        Uri.parse(userUrl+username),
        headers: {"Accept": "application/json;charset=utf-8",}
    );

    if (response.statusCode == 200) {
      final  json = jsonDecode(response.body);
      return DetailUser.fromJson(json["data"]);
    } else {
      print("from repository: " + response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }
}