// import 'dart:convert';
//
// import 'package:UdemyClone/events/AuthenEvent.dart';
// import 'package:UdemyClone/models/AuthUser.dart';
// import 'package:UdemyClone/models/LoginPayload.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../blocs/LoginBloc.dart';
//
// class CreateUserScreen extends StatefulWidget {
//   @override
//   _CreateUserScreenState createState() => _CreateUserScreenState();
// }
//
// class _CreateUserScreenState extends State<CreateUserScreen> {
//   final _userBloc = UserBloc();
//   final _textEditingController = <String, TextEditingController>{};
//
//   TextEditingController _getTextEditingController(String id){
//     return _textEditingController[id] ??= TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     _userBloc.dispose();
//     _textEditingController.values.forEach((element) {element.dispose();});
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create User'),
//       ),
//       body: Column(
//         children: [
//           TextField(
//             decoration: InputDecoration(
//               hintText: 'Enter username',
//             ),
//             controller: _getTextEditingController("username"),
//           ),
//           TextField(
//             decoration: InputDecoration(
//               hintText: 'Enter pwd',
//             ),
//             controller: _getTextEditingController("password"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               final username = _getTextEditingController("username").text.toString();
//               final password = _getTextEditingController("password").text.toString();
//
//               final event = LoginEvent(new LoginPayload( username, password));
//               _userBloc.authEventSink.add(event);
//             },
//             child: Text('Create User'),
//           ),
//           StreamBuilder<AuthUser>(
//             stream: _userBloc.authUserStream,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 final user = snapshot.data;
//                 return Column(
//                   children: [
//                     Text('User created:'),
//                     Text('Username: ${user.username}'),
//                     Text('Token: ${user.token}'),
//                     Text('Roles: ${user.role}'),
//                   ],
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else if(!snapshot.hasData){
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               else {
//                 return SizedBox.shrink();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }