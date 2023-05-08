import 'package:UdemyClone/models/Lecture.dart';
import 'package:flutter/material.dart';

class LectureItem extends StatelessWidget {
  final List<Lecture> lectures;
  num currentLectureId = 0;

  LectureItem({Key key, this.lectures}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lectures.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
            onTap: () {
              currentLectureId = lectures[index].id;
            },
            child: Container(
              padding: EdgeInsets.only(left: 16),
              height: 50,
              width: MediaQuery.of(context).size.width - 20,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                leading: Icon(
                  currentLectureId == lectures[index].id ? Icons.pause_circle: Icons.play_circle,
                  color: Colors.blue,),
                title: Text(
                  "${lectures[index].title}",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ));
      },
    );
  }
}
