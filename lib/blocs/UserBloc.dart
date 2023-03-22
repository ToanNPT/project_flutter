import 'dart:async';

import 'package:UdemyClone/models/AuthUser.dart';
import 'package:UdemyClone/repository/AuthenRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/AuthenEvent.dart';
import '../events/UserEvent.dart';
import '../states/UserState.dart';

class UserBloc {
  final _authenRepository = AuthenRepository();
  //out put
  final _userStreamController = StreamController<AuthUser>();

  //input from UI (receive event and data)
  final _userEventController = StreamController<AuthenEvent>();

  Stream<AuthUser> get authUserStream => _userStreamController.stream;
  Sink<AuthenEvent> get authEventSink => _userEventController.sink;

  UserBloc(){
    _userEventController.stream.listen((event) async {
      if(event is LoginEvent){
        try {
          final authUser = await _authenRepository.login(event.payload);
          _userStreamController.add(authUser);
        }
        catch(e) {
          _userStreamController.add(e);
        }
      }
    });

  }


  void dispose() {
    _userStreamController.close();
    _userEventController.close();
  }
  
}