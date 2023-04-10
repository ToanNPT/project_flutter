import 'package:UdemyClone/Screens/HomeScreens/MyList.dart';
import 'package:UdemyClone/blocs/CartBloc.dart';
import 'package:UdemyClone/blocs/WishListBloc.dart';
import 'package:UdemyClone/events/WishListEvent.dart';
import 'package:UdemyClone/models/Course.dart';
import 'package:UdemyClone/states/CartState.dart';
import 'package:UdemyClone/states/WishListState.dart';
import 'package:UdemyClone/widgets/viewHtml.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../events/CartEvent.dart';
import '../../notficationProvider/CartNotification.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key key}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Course course;

  String appName;
  String packageName;
  String version;
  String buildNumber;

  WishListBloc wishListBloc;
  CartBloc cartBloc;

  @override
  void initState() {
    super.initState();
    course = Get.arguments;
    wishListBloc = BlocProvider.of<WishListBloc>(context);
    cartBloc = BlocProvider.of<CartBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> share() async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
      print(appName);
      await FlutterShare.share(
        title: 'Share To',
        text: 'Udemy App Download Link',
        linkUrl: 'https://flutter.dev/',
      );
    }

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: InkWell(
                  child: Icon(EvaIcons.share),
                  onTap: () {
                    share();
                  },
                ),
              ),
            ),
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
            BlocListener<WishListBloc, WishListState>(
              bloc: wishListBloc,
              listener: (context, state) {
                if (state is WishListAddedResult) {
                  Navigator.pop(context);
                  if (state.isSuccess) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.scale,
                      title: 'Success',
                      desc: 'Add to wish list success',
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
                } else if (state is WishListAddingState) {
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
            BlocListener<CartBloc, CartState>(
              bloc: cartBloc,
              listener: (context, state){
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
                } else if(state is CartAddingState){
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
            )
          ],
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellowAccent,
                                  size: 18.0,
                                ),
                                Text(
                                  course.rate.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.bookmark_added,
                                  color: Colors.green,
                                  size: 18.0,
                                ),
                                Text(
                                  "${course.numStudents} Enrolled",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, top: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.language,
                                  color: Colors.white,
                                  size: 18.0,
                                ),
                                Text(
                                  "${course.language}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(13.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.people,
                                  color: Colors.blueAccent,
                                  size: 18.0,
                                ),
                                Text(
                                  "Created By ${course.accountName}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(13.0),
                        ),
                        child: FadeInImage(
                          height: 200.0,
                          width: 400.0,
                          placeholder:
                              AssetImage("assets/images/udemy_logo_2.png"),
                          image: NetworkImage(course.avatar),
                          fit: BoxFit.cover,
                        )),
                  ),
                  DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      animationDuration: Duration(milliseconds: 500),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                            padding: EdgeInsets.only(left: 6, right: 6),
                            child: TabBar(
                              splashFactory: NoSplash.splashFactory,
                              indicatorColor: Colors.white,
                              indicatorWeight: 4,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.white,
                              tabs: [
                                Tab(text: 'Description'),
                                Tab(text: 'Reviews'),
                              ],
                            ),
                          ),
                          Container(
                            height: 300,
                            margin: EdgeInsets.only(bottom: 20),
                            child: TabBarView(
                              children: [
                                ViewHtml(
                                  content: course.description,
                                ),
                                Container(
                                  child: Center(
                                    child: Text('Display Tab 2',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: Container(
                      height: 50.0,
                      width: 400.0,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          "Buy Now",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            //TODO: add func handle
                            context
                                .read<CartBloc>()
                                .add(CartAddedEvent(courseId: course.id));
                          },
                          child: Container(
                            height: 40.0,
                            width: 170.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.green,
                                size: 38,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            context
                                .read<WishListBloc>()
                                .add(WishListAddedEvent(courseId: course.id));
                          },
                          child: Container(
                            height: 40.0,
                            width: 170.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.favorite,
                                color: Colors.redAccent,
                                size: 42,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
