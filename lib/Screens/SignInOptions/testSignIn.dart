import 'package:UdemyClone/events/AuthenEvent.dart';
import 'package:UdemyClone/models/LoginPayload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../blocs/UserBloc.dart';

class CreateUserScreen extends StatefulWidget {
  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _userBloc = UserBloc();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _userBloc.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter name',
            ),
            controller: _nameController,
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter pwd',
            ),
            controller: _passwordController,
          ),
          ElevatedButton(
            onPressed: () {
              final name = _nameController.text;
              final password = _passwordController.text;

              final event = LoginEvent(new LoginPayload({name, password}));
              _userBloc.authEventSink.add(event);
            },
            child: Text('Create User'),
          ),
          StreamBuilder<User>(
            stream: _userBloc.userStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final user = snapshot.data!;
                return Column(
                  children: [
                    Text('User created:'),
                    Text('ID: ${user.id}'),
                    Text('Name: ${user.name}'),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}