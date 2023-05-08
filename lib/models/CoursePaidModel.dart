import 'Lecture.dart';

class CoursePaid {
  num id;
  String courseId;
  String chapterName;
  num numVideos;
  List<Lecture> lectures;


  CoursePaid(
      {this.id,
        this.courseId,
        this.chapterName,
        this.numVideos,
        this.lectures,
      });

  factory CoursePaid.fromJson(Map<String, dynamic> json) {
    return CoursePaid(
        id: json["id"],
        courseId: json["courseId"],
        chapterName: json["chapterName"],
        numVideos: json["numVideos"],
        lectures: (json['lectures'] as List<dynamic>).map((c) => Lecture.fromJson(c)).toList());
  }
}
