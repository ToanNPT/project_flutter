import 'dart:async';

import 'package:UdemyClone/Services/PrefStorage.dart';
import 'package:UdemyClone/models/LoginPayload.dart';
import 'package:UdemyClone/repository/AuthenRepository.dart';
import 'package:UdemyClone/repository/StorageRepository.dart';
import 'package:UdemyClone/ultis/constants.dart' as Constants;
class LoginBloc {
  final _authenRepository = AuthenRepository();
  final StorageRepository storageRepository = new StorageRepository();

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
        await storageRepository.writeSecureData(Constants.ACCESS_TOKEN_KEY, authUser.token);
        await storageRepository.writeSecureData(Constants.USERNAME, authUser.username);

        // print("ACCESS TOKEN STORED: " + await storageRepository.readSecureData(Constants.ACCESS_TOKEN_KEY));
        // print("USERNAME: " + await storageRepository.readSecureData(Constants.USERNAME));
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
