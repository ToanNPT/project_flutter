import 'package:UdemyClone/widgets/RateStar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/Course.dart';

class SlidableCourseItem extends StatelessWidget {
  final Course course;
  Function(String) callBack;
  Function(String) onAddCartCallBack;

  SlidableCourseItem({this.course, this.callBack, this.onAddCartCallBack});

  void _onDeleteItem() {
    callBack(course.id);
  }

  void _onAddToCart(){
    onAddCartCallBack(course.id);
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        //dismissible: DismissiblePane(onDismissed:null,),
        children: [
          SlidableAction(
            onPressed: (context) => _onDeleteItem(),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) => _onAddToCart(),
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.shopping_bag_outlined,
            label: 'Cart',
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.only(top: 5, bottom: 5),
          height: 110.0,
          width: MediaQuery.of(context).size.width - 16,
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
                    image: NetworkImage(course.avatar),
                    placeholder: AssetImage("assets/images/udemy_logo_2.jpg"),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 180,
                  child: Padding(
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
                        RateStar(rate: course.rate),
                        Padding(
                          padding: EdgeInsets.only(top: 5, left: 5),
                          child: Text(
                            course.numStudents.toString() + " enrolled",
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
      ),
    );
  }
}
