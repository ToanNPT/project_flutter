import 'package:UdemyClone/repository/CouresPaidRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/ContentCourseEvent.dart';
import '../states/ContentCourseState.dart';

class ContentCourseBloc extends Bloc<ContentCourseEvent, ContentCourseState> {
  ContentCourseBloc() : super(ContentCourseInitState());
  CoursePaidRepository repository = new CoursePaidRepository();

  @override
  Stream<ContentCourseState> mapEventToState(ContentCourseEvent event) async* {
    if (event is GetContentCourse) {
      yield ContentCourseLoadingState();
      var data = await repository.fetchData(event.courseId);
      yield ContentCourseLoadedState(data, contentCourse: data);
    }
  }
}
