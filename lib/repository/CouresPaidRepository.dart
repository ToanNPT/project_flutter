import 'dart:convert';

import 'package:UdemyClone/models/Course.dart';
import 'package:UdemyClone/models/CoursePaidModel.dart';
import 'package:UdemyClone/repository/StorageRepository.dart';
import 'package:UdemyClone/ultis/ApiEndpoint.dart' as ApiConst;
import 'package:UdemyClone/ultis/constants.dart' as Constants;
import 'package:http/http.dart';

class CoursePaidRepository {
  StorageRepository storageRepository;

  CoursePaidRepository() {
    this.storageRepository = new StorageRepository();
  }

  Future<List<CoursePaid>> fetchData(String courseId) async {
    String token =
        await storageRepository.readSecureData(Constants.ACCESS_TOKEN_KEY);
    //if (token.isEmpty) throw Exception("must login");

    Response response = await get(
        Uri.parse(ApiConst.CONTENT_COURSE + courseId + "/chapters"),
        headers: {
          "Accept": "application/json;charset=utf-8",
          //"Authorization": "Bearer " + token
        });

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body)["data"];
      var model = json.map((e) => CoursePaid.fromJson(e)).toList();
      return model;
    } else {
      print("from repository: " + response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Course>> getCoursePaids() async {
    String token = await storageRepository.readSecureData(Constants.ACCESS_TOKEN_KEY);
    String username = await storageRepository.readSecureData(Constants.USERNAME);

    if(token.isEmpty || username.isEmpty)
      throw Exception("must login");

    Response response = await get(
        Uri.parse(ApiConst.COURSE_PAIS + username + "?limit=10"),
        headers: {"Accept": "application/json;charset=utf-8",  "Authorization": "Bearer " + token});

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body)["data"]["content"];
      return jsonList.map((data) => Course.fromJson(data)).toList();
    } else {
      print("from repository: " + response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }
}
