import 'package:flutter/cupertino.dart';

import '../models/Course.dart';

@immutable
abstract class GridCourseState{}

class GridCourseInitState extends GridCourseState{}

class GirdCourseLoadingState extends GridCourseState{}

class GirdCourseGetState extends GridCourseState{
  final int page;
  GirdCourseGetState({this.page});
}

class GridCourseLoadedState extends GridCourseState{
  final List<Course> courses;
  final bool hasReachedMax;
  final int page;
  GridCourseLoadedState({this.courses, this.hasReachedMax, this.page});

  GridCourseLoadedState copyWith({List<Course> courses, bool hasReachedMex, int page}){
    return GridCourseLoadedState(
      courses: courses ?? this.courses,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page
    );
  }
}