import 'package:UdemyClone/blocs/ContentCourseBloc.dart';
import 'package:UdemyClone/states/ContentCourseState.dart';
import 'package:UdemyClone/widgets/LectureItem.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../events/ContentCourseEvent.dart';
import '../models/CoursePaidModel.dart';

class LearningScreen extends StatefulWidget {
  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  int currentChapterId;
  int currentVideoId;
  String currentLectureName;
  String desc;
  List<CoursePaid> chapters;
  ContentCourseBloc contentCourseBloc;

  void handleSetCurrentVideo(
      int chapterId, int lectureId, String lecturename, String desc, String url) {
    setState(() {
      this.currentChapterId = chapterId;
      this.currentVideoId = lectureId;
      this.currentLectureName = lecturename;
      this.desc = desc;
      videoPlayerController.dispose();
      chewieController.dispose();
      chewieController = null;
      _initPlayer(url);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    currentChapterId = 0;
    currentVideoId = 0;
    contentCourseBloc = BlocProvider.of<ContentCourseBloc>(context);
    currentLectureName = "";
    desc = "Sorry, but your teacher don't describe anything for this lecture!";
    context.read<ContentCourseBloc>().add(GetContentCourse(courseId: "COU013"));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    videoPlayerController.dispose();
    chewieController.dispose();
  }

  void _initPlayer(String url) async {
    videoPlayerController = VideoPlayerController.network(url);
    await videoPlayerController.initialize();

    setState(() {
      chewieController = chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        playbackSpeeds: [0.25, 0.5, 1, 2],
        looping: false,
      );
    });
  }

  String getFirstUrl(List<CoursePaid> chapters) {
    var lecs = chapters
        .where((element) => element.lectures != null)
        .expand((element) => element.lectures)
        .toList();
    return lecs.where((element) => element.link != null).toList()[0].link;
  }

  @override
  Widget build(BuildContext context) {
    num tabHeight = MediaQuery.of(context).size.width * 16 / 9;

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 40,
          title: Text(
            "Learning Room",
            style: TextStyle(fontSize: 16),
          ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<ContentCourseBloc, ContentCourseState>(
                bloc: contentCourseBloc,
                listener: (context, state) {
                  if (state is ContentCourseLoadedState) {
                    Navigator.pop(context);
                    setState(() {
                      chapters = state.contentCourse;
                      currentChapterId = state.contentCourse != null
                          ? state.contentCourse[0].id
                          : 0;
                      currentVideoId = state.contentCourse != null
                          ? state.contentCourse[0].lectures[0].id
                          : 0;
                      currentLectureName = state.contentCourse != null
                          ? state.contentCourse[0].lectures[0].title
                          : "";
                      String url = getFirstUrl(state.contentCourse);
                      _initPlayer(url);
                    });
                  } else if (state is ContentCourseLoadingState) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  }
                })
          ],
          child: SingleChildScrollView(
              child: Column(
            children: [
              chewieController != null
                  ? AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Chewie(
                        controller: chewieController,
                      ))
                  : AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Container(
                        color: Colors.black,
                        child: Container(
                          child: Center(
                            child: Text(
                              "Loading...",
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      )),
              Container(
                padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                margin: EdgeInsets.symmetric(horizontal: 0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white10,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: ExpansionTile(
                    title: Text(
                      "Lecture: $currentLectureName",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      maxLines: 2,
                    ),
                    trailing: const SizedBox(),
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "$desc",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  animationDuration: Duration(milliseconds: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.only(left: 6, right: 6),
                        child: TabBar(
                          splashFactory: NoSplash.splashFactory,
                          indicatorColor: Colors.deepOrange,
                          indicatorWeight: 4,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white,
                          tabs: [
                            Tab(text: 'Content'),
                            Tab(text: 'Overview'),
                          ],
                        ),
                      ),
                      Container(
                        height: tabHeight - 275 - 93,
                        margin: EdgeInsets.only(bottom: 20),
                        child: TabBarView(
                          children: [
                            ListView.builder(
                                itemCount:
                                    chapters != null ? chapters.length : 0,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(5),
                                    child: ExpansionTile(
                                      shape: RoundedRectangleBorder(
                                          //<-- SEE HERE
                                          side: BorderSide(
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      title: Text(
                                        "Section ${index}: ${chapters[index].chapterName}",
                                        style: TextStyle(
                                            color: currentChapterId ==
                                                    chapters[index].id
                                                ? Colors.teal
                                                : Colors.white,
                                            fontWeight: currentChapterId ==
                                                    chapters[index].id
                                                ? FontWeight.bold
                                                : FontWeight.w500),
                                      ),
                                      initiallyExpanded: false,
                                      textColor: Colors.white,
                                      children: [
                                        LectureItem(
                                          lectures: chapters[index].lectures,
                                          handleCurrentVideo:
                                              handleSetCurrentVideo,
                                          currentChapterId: currentChapterId,
                                          currentLectureId: currentVideoId,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                            Center(
                              child: Text("Display2"),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          )),
        ));
  }
}
