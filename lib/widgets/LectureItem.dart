import 'package:UdemyClone/models/Lecture.dart';
import 'package:flutter/material.dart';

class LectureItem extends StatelessWidget {
  final List<Lecture> lectures;
  final Function handleCurrentVideo;
  num currentLectureId;
  num currentChapterId;

  LectureItem(
      {Key key,
      this.lectures,
      this.handleCurrentVideo,
      this.currentChapterId,
      this.currentLectureId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lectures.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, index) {
        return GestureDetector(
            onTap: () {
              handleCurrentVideo(
                  lectures[index].chapterId,
                  lectures[index].id,
                  lectures[index].title,
                  lectures[index].description,
                  lectures[index].link);
            },
            child: Container(
                padding: EdgeInsets.only(left: 16),
                height: 50,
                width: MediaQuery.of(context).size.width - 20,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 1),
                  leading: Icon(
                    currentLectureId == lectures[index].id
                        ? Icons.pause_circle
                        : Icons.play_circle,
                    color: Colors.tealAccent,
                  ),
                  title: Text(
                    "${lectures[index].title}",
                    style: TextStyle(
                        color: currentLectureId == lectures[index].id
                            ? Colors.teal
                            : Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                )));
      },
    );
  }
}
