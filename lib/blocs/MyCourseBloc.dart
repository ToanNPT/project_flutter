import 'dart:ui';

import 'package:UdemyClone/events/CartEvent.dart';
import 'package:UdemyClone/events/MyCourseEvent.dart';
import 'package:UdemyClone/models/Course.dart';
import 'package:UdemyClone/repository/CartRepository.dart';
import 'package:UdemyClone/repository/CourseRepository.dart';
import 'package:UdemyClone/states/CartState.dart';
import 'package:UdemyClone/states/MyCourseState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCourseBloc extends Bloc<MyCourseEvent, MyCourseState> {
  MyCourseBloc() : super(MyCourseInitState());
  CourseRepository courseRepository = new CourseRepository();

  @override
  Stream<MyCourseState> mapEventToState(MyCourseEvent event) async* {
    if (event is GetMyCourseEvent) {
      yield MyCourseLoadingState();
      var data = await CourseRepository.fetchTopNewestCourse();
      yield MyCourseLoadedState(data);
    }
  }
}
