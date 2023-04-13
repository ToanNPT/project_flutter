
import 'package:UdemyClone/events/ReviewEvent.dart';
import 'package:UdemyClone/models/ReviewModel.dart';
import 'package:UdemyClone/repository/ReviewRepository.dart';
import 'package:UdemyClone/states/ReviewState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewBloc extends Bloc<ReviewEvent,ReviewState>{
  ReviewBloc() : super(ReviewInitState());
  ReviewRepository reviewRepository = new ReviewRepository();

  @override
  Stream<ReviewState> mapEventToState(ReviewEvent event) async*{
    if(event is GetReviewOfCourseEvent){
      yield ReviewLoadingState();
      List<ReviewModel> data = await reviewRepository.fetchReviewCourseData(event.courseId);
      yield ReviewLoadedState(data);
    }
  }
}