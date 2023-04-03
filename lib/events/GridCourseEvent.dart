import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


abstract class GridCourseEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetALlCourseAndPaging extends GridCourseEvent{
  GetALlCourseAndPaging();
}
class GridCourseLoading extends GridCourseEvent{}

class GridCourseInit extends GridCourseEvent{}

class GridCourseLoaded extends GridCourseEvent{}