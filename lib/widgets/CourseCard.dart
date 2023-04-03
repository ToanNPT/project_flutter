import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Screens/DetailsScreens/detailsScreen.dart';
import '../core/Colors/Hex_Color.dart';
import '../models/Course.dart';

class CourseCard extends StatelessWidget{
   final Course course;

  CourseCard({this.course});

  List<Widget> _generateStars(double rate){
    List<Widget> list = new List<Widget>();
    for(int i = 1; i <= 5; i++){
      if(i <= rate){
        list.add(Icon(
          Icons.star,
          color: Colors.yellow,
          size: 18.0,
        ));
      } else if(i - rate < 1.0){
        list.add(Icon(
          Icons.star_half,
          color: Colors.yellow,
          size: 18.0,
        ));
      }else if(i > rate){
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
          DetailsScreen(),
          transition: Transition.rightToLeftWithFade,
          arguments: this.course,
        );
      },
      child: Container(
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(10.0),
                child: FadeInImage(
                  height: 120.0,
                  width: 200.0,
                  fit: BoxFit.fill,
                  placeholder: AssetImage(
                      "assets/images/udemy_logo_2.jpg"),
                  image: NetworkImage(
                    course.avatar,
                  ),
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 10.0),
              child: SizedBox(
                width: 200.0,
                child: Text(
                  course.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 5.0),
              child: Text(
                course.accountName,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 14.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 5.0),
              child: Row(
                children: [
                  for(Widget i in _generateStars(course.rate)) i,

                  Text(
                    course.rate.toString(),
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    " (" +
                        course.numStudents.toString() +
                        ")",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 5.0),
              child: Row(
                children: [
                  Text(
                    course.price.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    width: 7.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 10.0),
              child: SizedBox(
                height: 30.0,
                width: 80.0,
                child: Container(
                  child: Center(
                    child: Text(
                      "Best Seller",
                      style: TextStyle(
                        color: HexColor('#3d0000'),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.yellow[300],
                    borderRadius:
                    BorderRadius.circular(4.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}