import 'package:UdemyClone/models/CartModel.dart';
import 'package:UdemyClone/models/Course.dart';

class MyCourseState {
  List<Course> courses;

  MyCourseState({this.courses});

  List<Course> get getItem => this.courses;
}

class MyCourseInitState extends MyCourseState {
  MyCourseInitState() : super(courses: null) {}
}

class MyCourseLoadingState extends MyCourseState {}

class MyCourseLoadedState extends MyCourseState {
  MyCourseLoadedState(List<Course> course) : super(courses: course);
}

