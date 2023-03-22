import 'dart:async';

import 'package:UdemyClone/models/AuthUser.dart';
import 'package:UdemyClone/models/LoginPayload.dart';
import 'package:UdemyClone/repository/AuthenRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/AuthenEvent.dart';
import '../events/UserEvent.dart';
import '../states/UserState.dart';

class LoginBloc {
  final _authenRepository = AuthenRepository();

  final _loadingController = StreamController<bool>.broadcast();

  Stream<bool> get isLoading => _loadingController.stream;

  LoginBloc(){
    _loadingController.sink.add(false);
  }
    Future<bool> login(LoginPayload payload) async {
      try {
        _loadingController.sink.add(true); // start loading process
        // your login logic here
        final authUser = await _authenRepository.login(payload);
        if(authUser != null)
          return true;
        return false;
      } catch (error) {
        // handle login error
        return false;
      } finally {
        _loadingController.sink.add(false); // stop loading process
      }
    }


  void dispose() {
    _loadingController.close();
  }
  
}