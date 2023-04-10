import 'package:UdemyClone/models/CartModel.dart';
import 'package:UdemyClone/repository/CartRepository.dart';
import 'package:flutter/cupertino.dart';

class CartItemsCount with ChangeNotifier {
  CartRepository repository = new CartRepository();

  num itemCount = 0;
  CartItemsCount() {
    _initializeData();
  }
  Future<void> _initializeData() async {
    // Perform an asynchronous operation to get some data
    var data = await repository.fetchData();
    if(data != null){
      itemCount = data.cartDetailList.length;
    }
    // Notify listeners that the data has been updated
    notifyListeners();
  }

  void increase() {
    itemCount ++;
    notifyListeners();
  }

  void decrease(){
    itemCount --;
    notifyListeners();
  }
}