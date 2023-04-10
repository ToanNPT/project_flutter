import 'package:UdemyClone/models/CartModel.dart';

class CartState {
  CartModel cart;

  CartState({this.cart});

 CartModel get getItem => this.cart;
}

class CartInitState extends CartState {
  CartInitState() : super(cart: null) {}
}

class CartLoadingState extends CartState {}

class CartDeletedState extends CartState {
  final String courseId;

  CartDeletedState({this.courseId});
}
class CartDeletingState extends CartState{
}

class CartDeletedResult extends CartState {
  final bool isSuccess;

  CartDeletedResult(CartModel cartItems, {this.isSuccess})
      : super(cart: cartItems);
}

class CartLoadedState extends CartState {
  CartLoadedState(CartModel cart) : super(cart: cart);
}

class CartAddedState extends CartState {
  final String courseId;

  CartAddedState({this.courseId});
}

class CartAddedResult extends CartState {
  final bool isSuccess;

  CartAddedResult({this.isSuccess});
}

class CartAddingState extends CartState {}
