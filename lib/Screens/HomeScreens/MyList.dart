import 'package:UdemyClone/blocs/CartBloc.dart';
import 'package:UdemyClone/blocs/WishListBloc.dart';
import 'package:UdemyClone/states/CartState.dart';
import 'package:UdemyClone/widgets/SlidableCartItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../events/CartEvent.dart';
import '../../notficationProvider/CartNotification.dart';
import '../DetailsScreens/DetailsScreen.dart';

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  CartBloc cartBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartBloc = new CartBloc();
  }

  void _onDeleteItem(String courseId) {
    context.read<CartBloc>().add(CartDeletedItemEvent(id: courseId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Your Cart"),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (BuildContext context, state) {
          if (state is CartInitState) {
            context.read<CartBloc>().add((GetCartItemsEvent()));
          } else if (state is CartLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartDeletedResult) {}
          return state is CartDeletingState
              ? Stack(
                  children: [
                    Container(
                      color: Colors.blueGrey.withOpacity(0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange.withOpacity(0.3),
                        ),
                      ),
                    ),
                    ListView.builder(
                      itemCount: state.cart != null
                          ? state.cart.cartDetailList.length
                          : 0,
                      itemBuilder: (BuildContext context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                                BlocProvider(
                                  create: (BuildContext context) =>
                                      WishListBloc(),
                                  child: DetailsScreen(),
                                ),
                                arguments: state.cart.cartDetailList[index]);
                          },
                          child: SlidableCartItem(
                              course: state.cart.cartDetailList[index],
                              callBack: _onDeleteItem),
                        );
                      },
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount:
                      state.cart != null ? state.cart.cartDetailList.length : 0,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                            MultiBlocProvider(
                              providers: [
                                BlocProvider<WishListBloc>(
                                  create: (BuildContext context) =>
                                      WishListBloc(),
                                ),
                                BlocProvider<CartBloc>(
                                  create: (BuildContext context) => CartBloc(),
                                ),
                              ],
                              child: ChangeNotifierProvider(
                                create: (context) => CartItemsCount(),
                                child: DetailsScreen(),
                              ),
                            ),
                            arguments: state.cart.cartDetailList[index]);
                      },
                      child: SlidableCartItem(
                          course: state.cart.cartDetailList[index],
                          callBack: _onDeleteItem),
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: ElevatedButton(
          child: Icon(
        Icons.ice_skating_sharp,
        color: Colors.white,
      )),
    );
  }
}
