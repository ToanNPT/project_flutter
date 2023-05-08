import 'package:UdemyClone/models/CoursePaidModel.dart';
import 'package:UdemyClone/models/Lecture.dart';
import 'package:UdemyClone/models/WishListModel.dart';
import 'package:flutter/cupertino.dart';

import '../models/Course.dart';

class ContentCourseState{
  List<CoursePaid> contents = List<CoursePaid>();

  ContentCourseState({this.contents});

  List<CoursePaid> get getContents => this.contents;

}

class ContentCourseInitState extends ContentCourseState{
  ContentCourseInitState() : super(contents: []){}
}

class ContentCourseLoadingState extends ContentCourseState{}

class ContentCourseLoadedState extends ContentCourseState{
  final List<CoursePaid> contentCourse;
  ContentCourseLoadedState(List<CoursePaid> contents, {this.contentCourse}) : super(contents: contentCourse);
}
