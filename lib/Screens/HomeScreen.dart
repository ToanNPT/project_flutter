import 'package:UdemyClone/Screens/HomeScreens/Account.dart';
import 'package:UdemyClone/Screens/HomeScreens/HomeCourse.dart';
import 'package:UdemyClone/Screens/HomeScreens/MyCourses.dart';
import 'package:UdemyClone/Screens/HomeScreens/Search.dart';
import 'package:UdemyClone/Screens/HomeScreens/WishList.dart';
import 'package:UdemyClone/blocs/CartBloc.dart';
import 'package:UdemyClone/blocs/ReviewCourseBloc.dart';
import 'package:UdemyClone/blocs/WishListBloc.dart';
import 'package:UdemyClone/notficationProvider/CartNotification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../blocs/CoursesBloc.dart';
import '../blocs/GirdCourseBloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();
  int currentIndex = 0;

  void onTap(int page) {
    setState(() {
      currentIndex = page;
    });
    pageController.jumpToPage(page);
    print(page);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        controller: pageController,
        children: [
          MultiBlocProvider(
            providers: [
              BlocProvider<CoursesBloc>(
                create: (BuildContext context) => CoursesBloc(),
              ),
              BlocProvider<GridCoursesBloc>(
                create: (BuildContext context) => GridCoursesBloc(),
              ),
            ],
            child: ChangeNotifierProvider(
              create: (context) => CartItemsCount(),
              child: HomeCourses(),
            ),
          ),
          Search(),
          MyCourses(),
          MultiBlocProvider(
            providers: [
              BlocProvider<WishListBloc>(
                create: (BuildContext context) => WishListBloc(),
              ),
              BlocProvider<CartBloc>(
                create: (BuildContext context) => CartBloc(),
              ),
              BlocProvider<ReviewCourseBloc>(
                create: (BuildContext context) => ReviewCourseBloc(),
              ),
            ],
            child: ChangeNotifierProvider(
              create: (context) => CartItemsCount(),
              child: WishList(),
            ),
          ),
          // BlocProvider(
          //   create: (BuildContext context) => WishListBloc(),
          //   child: ChangeNotifierProvider(
          //     create: (BuildContext context) => CartItemsCount(),
          //     child: WishList(),
          //   ),
          // ),
          MultiBlocProvider(
            providers: [
              BlocProvider<WishListBloc>(
                create: (BuildContext context) => WishListBloc(),
              ),
              BlocProvider<CartBloc>(
                create: (BuildContext context) => CartBloc(),
              ),
              BlocProvider<ReviewCourseBloc>(
                create: (BuildContext context) => ReviewCourseBloc(),
              ),
            ],
            child: ChangeNotifierProvider(
              create: (context) => CartItemsCount(),
              child: Account(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        iconSize: 26.0,
        selectedIconTheme: IconThemeData(color: Colors.redAccent),
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        currentIndex: currentIndex,
        backgroundColor: Colors.grey.shade900,
        unselectedIconTheme: IconThemeData(color: Colors.white),
        unselectedLabelStyle: TextStyle(color: Colors.white),
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Featured",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_video),
            label: "My Courses",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.heart),
            label: "Wishlist",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: "Account",
          ),
        ],
      ),
    );
  }
}
