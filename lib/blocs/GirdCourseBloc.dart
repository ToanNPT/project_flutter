
import 'package:UdemyClone/events/GridCourseEvent.dart';
import 'package:UdemyClone/models/PagingData.dart';
import 'package:UdemyClone/states/GirdCourseState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/Course.dart';
import '../repository/CourseRepository.dart';

class GridCoursesBloc extends Bloc<GridCourseEvent, GridCourseState> {
  GridCoursesBloc() : super(GridCourseInitState());

  @override
  Stream<GridCourseState> mapEventToState(GridCourseEvent event) async* {
    if(event is GetALlCourseAndPaging ){
      if(state is GridCourseInitState){
        var data = await CourseRepository.fetchAllCourse(0);
        yield GridCourseLoadedState(courses: data.data, hasReachedMax: data.isLastPage, page: 0);
      }else if(state is GridCourseLoadedState) {
        int nextPage = (state as GridCourseLoadedState).page +1;
        var data = await CourseRepository.fetchAllCourse(nextPage);
        var prevCourses = (state as GridCourseLoadedState).courses;
        yield GridCourseLoadedState(courses: prevCourses +data.data, hasReachedMax: data.isLastPage, page: nextPage);
      }
    }
  }
}