
import 'package:UdemyClone/models/Course.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class CourseState{}

class CourseInitState extends CourseState{}

class CourseLoadingState extends CourseState{}

class CourseGetState extends CourseState{}

class CourseLoadedState extends CourseState{
  final List<Course> courses;
  CourseLoadedState({this.courses});
}
class SearchLoadedState extends CourseState {
  final List<Course> courses;
  SearchLoadedState(this.courses);
}
class SearchError extends CourseState {
  final String errorMessage;
  SearchError(this.errorMessage);
}