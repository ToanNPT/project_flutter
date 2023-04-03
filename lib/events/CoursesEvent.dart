import 'package:flutter/cupertino.dart';

import '../models/Course.dart';

@immutable
abstract class CourseEvent {}

class CourseInitEvent extends CourseEvent{}

class  GetTopNewestCourseEvent extends CourseEvent{}

class SearchCourseEvent extends CourseEvent{
  final String query;
  SearchCourseEvent(this.query);
}


