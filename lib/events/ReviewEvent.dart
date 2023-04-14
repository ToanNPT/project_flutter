import 'package:equatable/equatable.dart';

abstract class ReviewEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetReviewEvent extends ReviewEvent {}

class ReviewLoadingEvent extends ReviewEvent {}

class ReviewLoadedEvent extends ReviewEvent {}

class GetReviewOfCourseEvent extends ReviewEvent {
  final String courseId;

  GetReviewOfCourseEvent(this.courseId);
}
