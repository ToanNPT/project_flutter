import 'dart:convert';

import 'package:UdemyClone/models/Course.dart';
import 'package:UdemyClone/ultis/ApiEndpoint.dart' as ApiConst;
import 'package:http/http.dart';

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
}
