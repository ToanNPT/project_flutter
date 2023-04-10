
import 'package:UdemyClone/events/GridCourseEvent.dart';
import 'package:UdemyClone/events/WishListEvent.dart';
import 'package:UdemyClone/models/PagingData.dart';
import 'package:UdemyClone/repository/WishListRepository.dart';
import 'package:UdemyClone/states/GirdCourseState.dart';
import 'package:UdemyClone/states/WishListState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supercharged/supercharged.dart';

import '../models/Course.dart';
import '../repository/CourseRepository.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {

  WishListBloc() : super(WishListInitState());
  WishListRepository wishListRepository = new WishListRepository();

  @override
  Stream<WishListState> mapEventToState(WishListEvent event) async* {

    if(event is GetWishListEvent){
      yield WishListLoadingState();
      var data = await wishListRepository.fetchData();
      yield WishListLoadedState(data, wishList: data);
    }

    if(event is WishListDeleteItemEvent){
      var isSuccess = await wishListRepository.deleteItem(event.id);

      if(isSuccess == true){
        var newState = state.wishes.filter((element) => element.courseInfo.id != event.id).toList();
        yield WishListDeletedResult(newState, isSuccess: true, wishList: newState);
      }else{
        yield WishListDeletedResult(state.wishes, isSuccess: false, wishList: state.wishes);
      }
    }

    if(event is WishListAddedEvent){
      yield WishListAddingState();
      var isSuccess = await wishListRepository.addItem(event.courseId);
      yield WishListAddedResult(isSuccess: isSuccess);
    }
  }
}