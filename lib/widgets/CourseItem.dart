import 'package:UdemyClone/widgets/RateStar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Course.dart';

class CourseItem extends StatelessWidget{
  final Course course;

  const CourseItem({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 110.0,
        width: 150.0,
        decoration: BoxDecoration(
          color: Colors.grey[900],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: FadeInImage(
                  height: 90.0,
                  width: 150.0,
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      course.avatar
                  ),
                  placeholder:
                  AssetImage("assets/images/udemy_logo_2.jpg"),
                ),
              ),
             Container(
               width: MediaQuery.of(context).size.width - 180,
               child:  Padding(
                 padding: const EdgeInsets.only(left: 10.0),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Container(
                       //width: MediaQuery.of(context).size.width- 150,
                       child: Text(
                         course.name,
                         overflow: TextOverflow.ellipsis,
                         maxLines: 2,
                         style: TextStyle(
                           color: Colors.grey.shade300,
                           fontSize: 18.0,
                         ),
                       ),
                     ),
                     Text(
                       course.accountName,
                       style: TextStyle(
                         color: Colors.grey.shade500,
                         fontSize: 14.0,
                       ),
                     ),
                      RateStar(rate: course.rate,),

                     Padding(
                       padding: EdgeInsets.only(top: 5, left: 5),
                       child: Text(
                             course.numStudents.toString() +
                             " enrolled",
                         style: TextStyle(
                           color: Colors.grey.shade500,
                           fontSize: 14.0,
                         ),
                       ),
                     )
                   ],
                 ),
               ),
             )
            ],
          ),
        ),
      ),
    );
  }

}