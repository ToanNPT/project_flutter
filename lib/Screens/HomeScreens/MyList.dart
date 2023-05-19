import 'dart:convert';

import 'package:UdemyClone/blocs/CartBloc.dart';
import 'package:UdemyClone/blocs/ReviewCourseBloc.dart';
import 'package:UdemyClone/blocs/WishListBloc.dart';
import 'package:UdemyClone/repository/StorageRepository.dart';
import 'package:UdemyClone/states/CartState.dart';
import 'package:UdemyClone/widgets/SlidableCartItem.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:UdemyClone/ultis/constants.dart' as Constants;
import '../../events/CartEvent.dart';
import '../../models/Course.dart';
import '../../notficationProvider/CartNotification.dart';
import '../DetailsScreens/DetailsScreen.dart';
import 'package:http/http.dart';
import 'package:UdemyClone/ultis/ApiEndpoint.dart' as ApiConst;

class MyList extends StatefulWidget {
  @override
  _MyListState createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  CartBloc cartBloc;
  List<Course> courseList;
  StorageRepository storageRepository;

  @override
  void initState() {
    super.initState();
    storageRepository = new StorageRepository();
    cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.add(GetCartItemsEvent());
  }

  @override
  void dispose() {
    cartBloc.close();
    super.dispose();
  }

  void _onDeleteItem(String courseId) {
    context.read<CartBloc>().add(CartDeletedItemEvent(id: courseId));
  }

  void _onSubmit() async{
    List<String> ids = courseList.map((e) => e.id).toList();
    String token =
        await storageRepository.readSecureData(Constants.ACCESS_TOKEN_KEY);
    if (token.isEmpty) throw Exception("must login");

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    var response = await get(
        Uri.parse(ApiConst.DOMAIN + "order?courses=" + ids.join(',')),
        headers: {
          "Accept": "application/json;charset=utf-8",
          "Authorization": "Bearer " + token
        });

    if (response.statusCode == 200) {
      var code = jsonDecode(response.body)["errorCode"];
      Navigator.pop(context);
      if(code == ""){
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.scale,
          title: 'Success',
          desc: 'Pay succes this course',
          btnOkOnPress: () {},
        )..show();
        setState(() {
          courseList = null;
        });
      }else{
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.scale,
          title: 'Error',
          desc: 'Oop! Try again, something was wrong',
          btnOkOnPress: () {},
        )..show();
      }
    } else {
      print("from repository: " + response.reasonPhrase);
      throw Exception(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Your Cart"),
        backgroundColor: Colors.black,
      ),
      body: MultiBlocListener(
          listeners: [
            BlocListener<CartBloc, CartState>(
              bloc: cartBloc,
              listener: (context, state) {
                if (state is CartDeletedResult) {
                  Navigator.pop(context);
                  if (state.isSuccess) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.scale,
                      title: 'Success',
                      desc: 'Remove item from cart success',
                      btnOkOnPress: () {},
                    )..show();
                    setState(() {
                      courseList = state.cart.cartDetailList;
                    });
                    context.read<CartItemsCount>().decrease();
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
                } else if (state is CartDeletingState) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                } else if (state is CartLoadedState) {
                  setState(() {
                    courseList = state.cart.cartDetailList;
                  });
                }
              },
            ),
          ],
          child: Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: courseList != null ? courseList.length : 0,
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
                              arguments: courseList[index]);
                        },
                        child: SlidableCartItem(
                            course: courseList[index], callBack: _onDeleteItem),
                      );
                    },
                  )),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Total Payment:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Text("${courseList == null ? 0.0 : courseList.fold(0.0, (previousValue, element) => previousValue + element.price)} VND",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 16)),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: GestureDetector(
                          onTap: () {
                            _onSubmit();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 16, bottom: 0),
                            height: 50.0,
                            width: 350.0,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Text(
                                "Check out",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
