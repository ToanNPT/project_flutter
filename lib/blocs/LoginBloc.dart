import 'dart:async';

import 'package:UdemyClone/Services/PrefStorage.dart';
import 'package:UdemyClone/models/LoginPayload.dart';
import 'package:UdemyClone/repository/AuthenRepository.dart';

class LoginBloc {
  final _authenRepository = AuthenRepository();

  final _loadingController = StreamController<bool>.broadcast();
  PrefStorage _prefStorage = PrefStorage();
  Stream<bool> get isLoading => _loadingController.stream;

  LoginBloc() {
    _loadingController.sink.add(false);
  }

  Future<bool> login(LoginPayload payload) async {
    try {
      _loadingController.sink.add(true);
      final authUser = await _authenRepository.login(payload);
      if (authUser != null) {
        _prefStorage.storeAccessToken(authUser.token);
        _prefStorage.storeUserInfo("username", authUser.username);

        return true;
      }
      return false;
    } catch (error) {
      return false;
    } finally {
      _loadingController.sink.add(false);
    }
  }

  void dispose() {
    _loadingController.close();
  }
}
