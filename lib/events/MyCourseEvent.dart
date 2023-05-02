import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


abstract class MyCourseEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetMyCourseEvent extends MyCourseEvent{}

class MyCourseLoadingEvent extends MyCourseEvent{}

class WishListLoadedEvent extends MyCourseEvent{}
