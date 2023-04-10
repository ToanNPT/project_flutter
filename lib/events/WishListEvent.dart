import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


abstract class WishListEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetWishListEvent extends WishListEvent{}

class WishListLoadingEvent extends WishListEvent{}

class WishListDeleteItemEvent extends WishListEvent{
  final String id;
  WishListDeleteItemEvent({this.id});
}

class WishListLoadedEvent extends WishListEvent{}

class WishListAddedEvent extends WishListEvent{
  final String courseId;
  WishListAddedEvent({this.courseId});
}