import 'package:UdemyClone/widgets/RateStar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/Course.dart';

class ReviewItem extends StatelessWidget{
  final String course;

  const ReviewItem({Key key, this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
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
              CircleAvatar(
                backgroundImage:AssetImage("assets/images/udemy_logo_2.jpg"),
                radius: 50,
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
                          "reviewer",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.grey.shade300,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      Text(
                        "autor",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14.0,
                        ),
                      ),
                      RateStar(rate: 5,),
                      Text(
                        "content content content content",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 14.0,
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