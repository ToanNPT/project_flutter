import 'package:UdemyClone/Screens/DetailsScreens/DetailsScreen.dart';
import 'package:UdemyClone/Screens/HomeScreens/MyList.dart';
import 'package:UdemyClone/blocs/CoursesBloc.dart';
import 'package:UdemyClone/blocs/GirdCourseBloc.dart';
import 'package:UdemyClone/events/GridCourseEvent.dart';
import 'package:UdemyClone/states/CourseState.dart';
import 'package:UdemyClone/states/GirdCourseState.dart';
import 'package:UdemyClone/widgets/CourseCard.dart';
import 'package:UdemyClone/widgets/CourseItem.dart';
import 'package:UdemyClone/Screens/HomeScreens/Search.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_transition/page_transition.dart';

import '../../events/CoursesEvent.dart';
import '../../models/Course.dart';
import 'package:bottom_loader/bottom_loader.dart';

class HomeCourses extends StatefulWidget {
  @override
  _HomeCoursesState createState() => _HomeCoursesState();
}

class _HomeCoursesState extends State<HomeCourses> {
  final CoursesBloc coursesBloc = new CoursesBloc();
  final GridCoursesBloc gridCoursesBloc = new GridCoursesBloc();
  final _scrollController = ScrollController();
  int page = 0;
  bool _canLoadMore = true;
  List<Course> courseItems = [];
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    super.initState();
    coursesBloc.add(GetTopNewestCourseEvent());
    gridCoursesBloc.add(GridCourseInit());
    _canLoadMore = true;
    page = 0;
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      context
          .read<GridCoursesBloc>()
          .add(GetALlCourseAndPaging());
    }
  }

  @override
  void dispose() {
    coursesBloc.close();
    gridCoursesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Featured"),
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              child: InkWell(
                child: Icon(EvaIcons.shoppingCartOutline),
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                        child: MyList(),
                        type: PageTransitionType.leftToRightWithFade),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: RefreshIndicator(
        // ignore: missing_return
        onRefresh: () {
          context.read<CoursesBloc>().add(GetTopNewestCourseEvent());
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 180.0,
                  width: 400.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/udemy_3.jpg'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                  height: 60.0,
                  width: 400.0,
                  decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          HexColor('#20477a'),
                          HexColor('#2377cc'),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Courses now on sale",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17.0,
                          ),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          "1 Day Left",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Best Seller",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              SizedBox(
                  height: 300,
                  width: 400,
                  child: BlocBuilder<CoursesBloc, CourseState>(
                      builder: (BuildContext context, state) {
                    if (state is CourseInitState) {
                      context
                          .read<CoursesBloc>()
                          .add(GetTopNewestCourseEvent());
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is CourseLoadingState) {
                      return Center(child: CircularProgressIndicator(),);
                    } else if (state is CourseLoadedState) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.courses.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CourseCard(course: state.courses[index]);
                          });
                    } else {
                      return Center();
                    }
                  })),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Courses in Udemy",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 180,
                width: 400,
                child: BlocBuilder<GridCoursesBloc, GridCourseState>(
                  builder: (BuildContext context, state) {
                    if (state is GridCourseInitState) {
                      context
                          .read<GridCoursesBloc>()
                          .add(GetALlCourseAndPaging());
                      return Center(child: CircularProgressIndicator(),);
                    }
                    else if (state is GridCourseLoadedState) {
                     // this._canLoadMore = !state.hasReachedMax;
                      //if (_canLoadMore) this.page++;
                      return ListView.builder(
                        itemCount: state.hasReachedMax
                            ? state.courses.length
                            : state.courses.length + 1,
                        controller: _scrollController,
                        itemBuilder: (BuildContext context, int index) {
                          return index > state.courses.length -1
                              ? Center(child: CircularProgressIndicator(color: Colors.white,),)
                              : GestureDetector(
                                  onTap: () {
                                    Get.to(DetailsScreen(),
                                        arguments: state.courses[index]);
                                  },
                                  child: CourseItem(
                                      course: state.courses[index]),
                                );
                        },
                      );
                    }else{
                      return Center();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
