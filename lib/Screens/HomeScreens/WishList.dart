import 'package:UdemyClone/Screens/HomeScreens/MyList.dart';
import 'package:UdemyClone/blocs/ReviewCourseBloc.dart';
import 'package:UdemyClone/blocs/WishListBloc.dart';
import 'package:UdemyClone/events/CartEvent.dart';
import 'package:UdemyClone/events/WishListEvent.dart';
import 'package:UdemyClone/models/WishListModel.dart';
import 'package:UdemyClone/states/WishListState.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../blocs/CartBloc.dart';
import '../../notficationProvider/CartNotification.dart';
import '../../states/CartState.dart';
import '../../widgets/SlidableCourseItem.dart';
import '../DetailsScreens/DetailsScreen.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  WishListBloc wishListBloc;
  CartBloc cartBloc;
  List<WishListModel> wishes;

  void _onDeleteItem(String courseId) {
    context.read<WishListBloc>().add(WishListDeleteItemEvent(id: courseId));
  }

  void _onAddToCart(String courseId) {
    context.read<CartBloc>().add(CartAddedEvent(courseId: courseId));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wishListBloc = BlocProvider.of<WishListBloc>(context);
    cartBloc = BlocProvider.of<CartBloc>(context);
    context.read<WishListBloc>().add(GetWishListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            "Wish List",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          actions: [
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, right: 32, left: 8),
                  child: Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      child: Icon(EvaIcons.shoppingCartOutline),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                              child: BlocProvider(
                                create: (BuildContext context) => CartBloc(),
                                child: MyList(),
                              ),
                              type: PageTransitionType.leftToRightWithFade),
                        );
                      },
                    ),
                  ),
                ),
                Builder(
                  builder: (context) => Consumer<CartItemsCount>(
                    builder: (context, mybloc, child) {
                      return Positioned(
                        top: 5,
                        right: 12,
                        child: mybloc.itemCount != null && mybloc.itemCount > 0
                            ? Container(
                                padding: EdgeInsets.all(5),
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Center(
                                  child: Text(
                                    mybloc.itemCount.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ))
                            : Center(),
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<CartBloc, CartState>(
              bloc: cartBloc,
              listener: (context, state) {
                if (state is CartAddedResult) {
                  Navigator.pop(context);

                  if (state.isSuccess) {
                    context.read<CartItemsCount>().increase();
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.scale,
                      title: 'Success',
                      desc: 'Add to cart success',
                      btnOkOnPress: () {},
                    )..show();
                  } else {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.scale,
                      title: 'Error',
                      desc: 'Oop! Try again, something was wrong',
                      btnOkOnPress: () {},
                    )..show();
                  }
                } else if (state is CartAddingState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                }
              },
            ),
            BlocListener<WishListBloc, WishListState>(
                bloc: wishListBloc,
                listener: (context, state) {
                  if (state is WishListLoadingState) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  } else if (state is WishListLoadedState) {
                    Navigator.pop(context);
                    setState(() {
                      wishes = state.wishes;
                    });
                  } else if (state is WishListDeletedResult) {
                    setState(() {
                      wishes = state.wishes;
                    });
                  }
                })
          ],
          child: ListView.builder(
            itemCount: wishes != null ? wishes.length : 0,
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
                            create: (BuildContext context) =>
                                CartBloc(),
                          ),
                          BlocProvider<ReviewCourseBloc>(
                            create: (BuildContext context) =>
                                ReviewCourseBloc(),
                          ),
                        ],
                        child: ChangeNotifierProvider(
                          create: (context) => CartItemsCount(),
                          child: DetailsScreen(),
                        ),
                      ),
                      arguments: wishes[index].courseInfo);
                },
                child: SlidableCourseItem(
                  course: wishes[index].courseInfo,
                  callBack: _onDeleteItem,
                  onAddCartCallBack: _onAddToCart,
                ),
              );
            },
          ),
        ));
  }
}
