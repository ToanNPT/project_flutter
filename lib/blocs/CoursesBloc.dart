import 'package:UdemyClone/events/CoursesEvent.dart';
import 'package:UdemyClone/models/Course.dart';
import 'package:UdemyClone/repository/CourseRepository.dart';
import 'package:UdemyClone/states/CourseState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoursesBloc extends Bloc<CourseEvent, CourseState> {
  CoursesBloc() : super(CourseInitState());

  @override
  Stream<CourseState> mapEventToState(CourseEvent event) async* {
    if (event is GetTopNewestCourseEvent) {
      yield CourseLoadingState();
      List<Course> _courses = await CourseRepository.fetchTopNewestCourse();
      yield CourseLoadedState(courses: _courses);
    }
  }

}