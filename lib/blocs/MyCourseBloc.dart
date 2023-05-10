import 'package:UdemyClone/events/MyCourseEvent.dart';
import 'package:UdemyClone/repository/CouresPaidRepository.dart';
import 'package:UdemyClone/repository/CourseRepository.dart';
import 'package:UdemyClone/states/MyCourseState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCourseBloc extends Bloc<MyCourseEvent, MyCourseState> {
  MyCourseBloc() : super(MyCourseInitState());
  CoursePaidRepository courseRepository = new CoursePaidRepository();

  @override
  Stream<MyCourseState> mapEventToState(MyCourseEvent event) async* {
    if (event is GetMyCourseEvent) {
      yield MyCourseLoadingState();
      var data = await courseRepository.getCoursePaids();
      yield MyCourseLoadedState(data);
    }
  }
}
