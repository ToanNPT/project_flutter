import 'package:UdemyClone/models/ReviewModel.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class ReviewState{}

class ReviewInitState extends ReviewState{}

class ReviewLoadingState extends ReviewState{}

class ReviewCourseLoadingState extends ReviewState{}
class ReviewCourseLoadedState extends ReviewState{
  final List<ReviewModel> reviews;
  ReviewCourseLoadedState(this.reviews);
}

class ReviewGetState extends ReviewState{}

class ReviewLoadedState extends ReviewState{
  final List<ReviewModel> reviews;
  ReviewLoadedState(this.reviews);
}