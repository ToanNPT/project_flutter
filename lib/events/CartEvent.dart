import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetCartItemsEvent extends CartEvent {}

class CartLoadingEvent extends CartEvent {}

class CartDeletingEvent extends CartEvent{}

class CartDeletedItemEvent extends CartEvent {
  final String id;

  CartDeletedItemEvent({this.id});
}

class CartLoadedEvent extends CartEvent {}

class CartAddedEvent extends CartEvent {
  final String courseId;

  CartAddedEvent({this.courseId});
}
