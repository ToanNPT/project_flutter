import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


abstract class ContentCourseEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetContentCourse extends ContentCourseEvent{
  String courseId;
  GetContentCourse({this.courseId});
}
