import 'dart:ui';

import 'package:UdemyClone/events/CartEvent.dart';
import 'package:UdemyClone/repository/CartRepository.dart';
import 'package:UdemyClone/states/CartState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitState());
  CartRepository cartRepository = new CartRepository();

  @override
  Stream<CartState> mapEventToState(CartEvent event) async* {
    if (event is GetCartItemsEvent) {
      yield CartLoadingState();
      var data = await cartRepository.fetchData();
      yield CartLoadedState(data);
    }

    if(event is CartDeletedItemEvent){
      yield CartDeletingState();
      var isSuccess = await cartRepository.deleteItem(event.id);
      if(isSuccess == true){
        var newData = await cartRepository.fetchData();
        yield CartDeletedResult(newData, isSuccess: isSuccess);
      }else{
        yield CartDeletedResult(state.cart, isSuccess: isSuccess);
      }
    }

    if(event is CartAddedEvent){
      yield CartAddingState();
      var isSuccess = await cartRepository.addItem(event.courseId);
      yield CartAddedResult( isSuccess: isSuccess);
    }

    // if (event is WishListDeleteItemEvent) {
    //   var isSuccess = await wishListRepository.deleteItem(event.id);
    //
    //   if (isSuccess == true) {
    //     var newState = state.wishes
    //         .filter((element) => element.courseInfo.id != event.id)
    //         .toList();
    //     yield WishListDeletedResult(newState,
    //         isSuccess: true, wishList: newState);
    //   } else {
    //     yield WishListDeletedResult(state.wishes,
    //         isSuccess: false, wishList: state.wishes);
    //   }
    // }
    //
    // if (event is WishListAddedEvent) {
    //   yield WishListAddingState();
    //   var isSuccess = await wishListRepository.addItem(event.courseId);
    //   yield WishListAddedResult(isSuccess: isSuccess);
    // }
  }
}
