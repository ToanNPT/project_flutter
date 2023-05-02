import 'package:UdemyClone/states/MyCourseState.dart';
import 'package:UdemyClone/widgets/CourseCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/MyCourseBloc.dart';
import '../../events/MyCourseEvent.dart';
import '../../models/Course.dart';
import '../../widgets/MyCourseCard.dart';

class MyCourses extends StatefulWidget {
  @override
  _MyCoursesState createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  MyCourseBloc myCourseBloc;
  List<Course> courses;
  @override
  void initState() {
    super.initState();
    myCourseBloc = BlocProvider.of<MyCourseBloc>(context);
    myCourseBloc.add(GetMyCourseEvent());
  }

  @override
  void dispose() {
    super.dispose();
    myCourseBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("My Courses"),
        backgroundColor: Colors.black,
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<MyCourseBloc, MyCourseState>(
            bloc: myCourseBloc,
            listener: (context, state) {
              if (state is MyCourseLoadingState) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              } else if (state is MyCourseLoadedState) {
                Navigator.pop(context);
                setState(() {
                  this.courses = state.courses;
                });
              }
            },
          ),
        ],
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0
            ),
            itemCount: courses != null ? courses.length : 0,
          itemBuilder: (BuildContext context, index){
            return MyCourseCard(course: this.courses[index],);
          }

        ),
      )
    );
  }
}
