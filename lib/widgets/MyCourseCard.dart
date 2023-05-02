import 'package:UdemyClone/blocs/ReviewCourseBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Screens/DetailsScreens/DetailsScreen.dart';
import '../blocs/CartBloc.dart';
import '../blocs/WishListBloc.dart';
import '../models/Course.dart';
import '../notficationProvider/CartNotification.dart';

class MyCourseCard extends StatelessWidget {
  final Course course;

  MyCourseCard({this.course});

  List<Widget> _generateStars(double rate) {
    List<Widget> list = new List<Widget>();
    for (int i = 1; i <= 5; i++) {
      if (i <= rate) {
        list.add(Icon(
          Icons.star,
          color: Colors.yellow,
          size: 18.0,
        ));
      } else if (i - rate < 1.0) {
        list.add(Icon(
          Icons.star_half,
          color: Colors.yellow,
          size: 18.0,
        ));
      } else if (i > rate) {
        list.add(Icon(
          Icons.star_border,
          color: Colors.yellow,
          size: 18.0,
        ));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
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
              child: DetailsScreen(),
            ),
          ),
          //transition: Transition.rightToLeftWithFade,
          arguments: course,
        );
      },
      child: Container(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  height: 90.0,
                  width: 150.0,
                  fit: BoxFit.fill,
                  placeholder: AssetImage("assets/images/udemy_logo_2.jpg"),
                  image: NetworkImage(
                    course.avatar,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: 200.0,
                child: Text(
                  course.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5.0),
              child: Text(
                course.accountName,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5.0),
              child: Row(
                children: [
                  for (Widget i in _generateStars(course.rate)) i,
                  Text(
                    course.rate.toString(),
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 7.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
