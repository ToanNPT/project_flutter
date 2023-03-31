import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class RateStar extends StatelessWidget {
  double rate;
  RateStar({this.rate});

  @override
  Widget build(BuildContext context) {
    List<Widget> list = new List<Widget>();
    // TODO: implement build
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
    return Row(children: list);
  }
}