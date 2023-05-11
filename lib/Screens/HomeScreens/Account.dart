import 'package:UdemyClone/blocs/DetailUserBloc.dart';
import 'package:UdemyClone/events/AuthenEvent.dart';
import 'package:UdemyClone/states/UserDetailState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Account extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('User Detail'),
      ),
      body: BlocProvider(
        create: (context) => DetailUserBloc(), // Create an instance of UserDetailBloc
        child: UserDetailWidget(),
      ),
    );
  }
}

class UserDetailWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final DetailUserBloc userDetailBloc = BlocProvider.of<DetailUserBloc>(context);

    // Dispatch the FetchUserDetailEvent when the widget is built
    userDetailBloc.add(DetailUserEvent());

    return Center(
      child: BlocBuilder<DetailUserBloc, UserDetailState>(
        builder: (context, state) {
          if (state is UserDetailLoadingState) {
            return CircularProgressIndicator();
          } else if (state is UserDetailLoadedState) {
            final user = state.detailUser;
            // Display the user details in the UI
            // return Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     CircleAvatar(
            //       backgroundImage: NetworkImage(user.avatar),
            //     ),
            //     Text('Username: ${user.username}'),
            //     Text('Email: ${user.email}'),
            //     Text('Role: ${user.role}'),
            //     Text('Birthday: ${user.birthdate}'),
            //     Text('Gender: ${user.gender}'),
            //   ],
            // );
            return Container(
              color: Colors.black,
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Image(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 3,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://cdn.sforum.vn/sforum/wp-content/uploads/2023/05/cach-tai-udemy.jpg'),
                      ),
                      Positioned(
                        bottom: -20.0,
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(user.avatar),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    title: Center(
                      child: Text(
                        user.fullname,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            size: 30,
                              color: Colors.white
                          ),
                          SizedBox(width: 10),
                          Text(
                            user.phone,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.mail,
                            size: 30,
                              color: Colors.white
                          ),
                          SizedBox(width: 10),
                          Text(
                            user.email,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.person,
                            size: 30,
                              color: Colors.white
                          ),
                          SizedBox(width: 10),
                          Text(
                            user.role,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
                    child: ListTile(
                      title: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 30,
                              color: Colors.white
                          ),
                          SizedBox(width: 10),
                          Text(
                            user.birthdate.substring(0, 10),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );

          } else {
            // Handle other states if necessary
            return Container();
          }
        },
      ),
    );

  }
}
