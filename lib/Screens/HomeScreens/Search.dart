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
        title: Text('Search Posts'),
      ),
      body: BlocProvider(
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
                        return ListTile(
                          title: Text(post.name),
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
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search',
              ),
            ),
          ),
          SizedBox(width: 8.0),
          ElevatedButton(
            child: Text('Search'),
            onPressed: () {
              final query = _controller.text.trim();
              if (query.isNotEmpty) {
                BlocProvider.of<CoursesBloc>(context).add(SearchCourseEvent(query));
              }
            },
          ),
        ],
      ),
    );
  }
}


