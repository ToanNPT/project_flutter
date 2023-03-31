import 'dart:convert';

import 'package:UdemyClone/models/Course.dart';
import 'package:UdemyClone/models/PagingData.dart';
import 'package:UdemyClone/ultis/ApiEndpoint.dart' as ApiConst;
import 'package:http/http.dart';
import 'package:supercharged/supercharged.dart';

class CourseRepository {
  static Future<List<Course>> fetchTopNewestCourse() async {
    Response response = await get(
        Uri.parse(ApiConst.NEWEST_COURSE_ENDPOINT + "?limit=10"),
        headers: {"Accept": "application/json;charset=utf-8"}
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body)["data"];
      return jsonList.map((data) => Course.fromJson(data)).toList();
    } else {
      print("from repository: " + response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<PagingData> fetchAllCourse(int page) async {
    Response response = await get(
        Uri.parse(ApiConst.GET_ALL_COURSE_ENDPOINT + "?page=" +page.toString()),
        headers: {"Accept": "application/json;charset=utf-8"}
    );

    if (response.statusCode == 200) {
      bool isLastPage = jsonDecode(response.body)["data"]["last"] == "true" ? true : false;
      final List<dynamic> jsonList = jsonDecode(response.body)["data"]["content"];
      final coursesData =  jsonList.map((data) => Course.fromJson(data)).toList();
      isLastPage = coursesData.length < 10 ? true : false;
      return new PagingData(isLastPage: isLastPage, data: coursesData);
    } else {
      print("from repository: " + response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<List<Course>> fetchFilterCourse(String value) async {
    final url = Uri.parse(ApiConst.SEARCH_ENDPOINT);
    final headers = {'Content-Type': 'application/json'};
    final myObjectsList = [
      {'key': 'name',
        'value': value,
        'operation': 'MATCH'
      },
    ];
    final body = jsonEncode(myObjectsList);

    Response response = await post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body)["data"]["content"];
      return jsonList.map((data) => Course.fromJson(data)).toList();
    } else {
      print("from repository: " + response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }
}
