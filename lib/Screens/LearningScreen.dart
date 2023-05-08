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
  List<CoursePaid> chapters;
  ContentCourseBloc contentCourseBloc;

  @override
  void initState() {
    // TODO: implement initState
    currentChapterId = 0;
    currentVideoId = 0;
    contentCourseBloc = BlocProvider.of<ContentCourseBloc>(context);
    context.read<ContentCourseBloc>().add(GetContentCourse(courseId: "COU013"));
    _initPlayer();
    super.initState();
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    videoPlayerController.dispose();
    chewieController.dispose();
  }

  void _initPlayer() async {
    videoPlayerController = VideoPlayerController.network(
        'https://toannpt-onlinecourses.s3.amazonaws.com/toanpt01-C_01-11-Testoot%20fast%20and%20deep%3F11ss');
    await videoPlayerController.initialize();
    setState(() {
      chewieController = chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Udemy Learning"),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // AspectRatio(
              //     aspectRatio: 4/3,
              //     child: Chewie(
              //       controller: chewieController,
              //     )),
              chewieController != null
                  ? AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Chewie(
                        controller: chewieController,
                      ))
                  : AspectRatio(
                      aspectRatio: 5,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              DefaultTabController(
                  length: 2,
                  initialIndex: 0,
                  animationDuration: Duration(milliseconds: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        height: 300,
                        margin: EdgeInsets.only(bottom: 20),
                        child: TabBarView(
                          children: [
                            ListView.builder(
                                itemCount: chapters != null ? chapters.length : 0,
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
                                            color: currentChapterId == index
                                                ? Colors.orange
                                                : Colors.white,
                                            fontWeight:
                                            currentChapterId == index
                                                ? FontWeight.bold
                                                : FontWeight.w400),
                                      ),
                                      initiallyExpanded: false,
                                      textColor: Colors.white,
                                      children: [
                                        LectureItem(lectures: chapters[index].lectures),
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
          ),
        ));
  }
}
