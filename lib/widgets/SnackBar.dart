import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _SnackBar extends StatelessWidget{
  final String content;

  _SnackBar({this.content});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SnackBar(
      content: Text(content, style: const TextStyle(color: Colors.green),),
      backgroundColor: Colors.blueGrey,
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
  }

}