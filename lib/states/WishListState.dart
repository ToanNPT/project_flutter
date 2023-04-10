import 'package:UdemyClone/models/WishListModel.dart';
import 'package:flutter/cupertino.dart';

import '../models/Course.dart';

class WishListState{
  List<WishListModel> wishes = List<WishListModel>();

  WishListState({this.wishes});

  List<WishListModel> get getWishes => this.wishes;

}

class WishListInitState extends WishListState{
  WishListInitState() : super(wishes: []){}
}

class WishListLoadingState extends WishListState{}

class WishListDeletedState extends WishListState{
  final String courseId;
  WishListDeletedState({this.courseId});
}

class WishListDeletedResult extends WishListState{
  final bool isSuccess;
  final List<WishListModel> wishList;
  WishListDeletedResult(List<WishListModel> wishes, {this.isSuccess, this.wishList}) : super(wishes: wishes);
}

class WishListLoadedState extends WishListState{
  final List<WishListModel> wishList;
  WishListLoadedState(List<WishListModel> wishes, {this.wishList}) : super(wishes: wishes);
}

class WishListAddedResult extends WishListState{
  final bool isSuccess;
  WishListAddedResult({this.isSuccess});
}

class WishListAddingState extends WishListState{}