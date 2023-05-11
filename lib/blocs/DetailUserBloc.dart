import 'package:UdemyClone/events/AuthenEvent.dart';
import 'package:UdemyClone/events/CoursesEvent.dart';
import 'package:UdemyClone/models/Course.dart';
import 'package:UdemyClone/models/DetailUser.dart';
import 'package:UdemyClone/repository/CourseRepository.dart';
import 'package:UdemyClone/repository/DetailUserRepository.dart';
import 'package:UdemyClone/states/CourseState.dart';
import 'package:UdemyClone/states/UserDetailState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class DetailUserBloc extends Bloc<AuthenEvent, UserDetailState> {
  DetailUserBloc() : super(UserDetailInitState());
  DetailUserRepository detailUserRepository = new DetailUserRepository();
  @override
  Stream<UserDetailState> mapEventToState(AuthenEvent event) async* {
    if (event is DetailUserEvent) {
      yield UserDetailLoadingState();
      DetailUser detailUser = await detailUserRepository.getDetail();
      yield UserDetailLoadedState(detailUser: detailUser);
    }
  }

}