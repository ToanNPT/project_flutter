
import 'package:UdemyClone/events/ReviewEvent.dart';
import 'package:UdemyClone/models/ReviewModel.dart';
import 'package:UdemyClone/repository/ReviewRepository.dart';
import 'package:UdemyClone/states/ReviewState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewCourseBloc extends Bloc<ReviewEvent,ReviewState>{
  ReviewCourseBloc() : super(ReviewInitState());
  ReviewRepository reviewRepository = new ReviewRepository();

  @override
  Stream<ReviewState> mapEventToState(ReviewEvent event) async*{
    if(event is GetReviewOfCourseEvent){
      yield ReviewCourseLoadingState();
      var data = await reviewRepository.fetchReviewCourseData(event.courseId);
      if(data.length>0){
        yield ReviewCourseLoadedState(data);
      }else{
        yield NoReviewCourseLoadedState();
      }
    }
  }
}