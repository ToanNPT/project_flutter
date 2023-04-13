import 'dart:convert';

import 'package:UdemyClone/models/ReviewModel.dart';
import 'package:UdemyClone/repository/StorageRepository.dart';
import 'package:UdemyClone/ultis/ApiEndpoint.dart' as ApiConst;
import 'package:http/http.dart';

class ReviewRepository {
  StorageRepository storageRepository;

  ReviewRepository() {
    this.storageRepository = new StorageRepository();
  }

  Future<List<ReviewModel>> fetchReviewCourseData(String courseId) async {
    Response response = await get(
        Uri.parse(ApiConst.COURSE_REVIEWS_ENDPOINT+"/"+courseId),
        headers: {"Accept": "application/json;charset=utf-8",}
    );

    if (response.statusCode == 200) {
      final List<dynamic>dataFromJson = jsonDecode(response.body)["data"]["content"];
      return dataFromJson.map((data) => ReviewModel.fromJson(data)).toList();
    } else {
      print("from repository: " + response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }
}
