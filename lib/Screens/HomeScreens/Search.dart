import 'package:UdemyClone/blocs/CoursesBloc.dart';
import 'package:UdemyClone/states/CourseState.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../events/CoursesEvent.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Search Courses'),
      ),
      body: Container(
        color: Colors.black,
        child: BlocProvider(
          create: (context) => CoursesBloc(),
          child: Column(
            children: [
              SearchBar(),
              Expanded(
                child: BlocBuilder<CoursesBloc, CourseState>(
                  builder: (context, state) {
                    if (state is SearchLoadedState) {
                      return ListView.builder(
                        itemCount: state.courses.length,
                        itemBuilder: (context, index) {
                          final post = state.courses[index];
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: (
                                          "assets/images/udemy_logo_2.jpg"),
                                      image:  post.avatar,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          post.name,
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          post.description,
                                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(Icons.star, color: Colors.yellow, size: 16),
                                            Icon(Icons.star, color: Colors.yellow, size: 16),
                                            Icon(Icons.star, color: Colors.yellow, size: 16),
                                            Icon(Icons.star_border, color: Colors.yellow, size: 16),
                                            Icon(Icons.star_border, color: Colors.yellow, size: 16),
                                            SizedBox(width: 8),
                                            Text(
                                              '4.0',
                                              style: TextStyle(fontSize: 14,color: Colors.white),
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              post.price.toString(),
                                              style: TextStyle(fontSize: 14,color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (state is SearchError) {
                      return Center(
                        child: Text(state.errorMessage),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 2.0,
                  ),
                ),
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search',
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),

          ),
          SizedBox(width: 8.0),
          ElevatedButton.icon(
            icon: Icon(
              Icons.search,
              size: 32,
              color: Colors.white,
            ),
            label: Text(''),
            onPressed: () {
              final query = _controller.text.trim();
              if (query.isNotEmpty) {
                BlocProvider.of<CoursesBloc>(context).add(SearchCourseEvent(query));
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}


