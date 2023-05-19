import 'dart:async';

import 'package:UdemyClone/Services/PrefStorage.dart';
import 'package:UdemyClone/models/LoginPayload.dart';
import 'package:UdemyClone/models/RegisterPayload.dart';
import 'package:UdemyClone/repository/AuthenRepository.dart';
import 'package:UdemyClone/repository/RegisterRepository.dart';
import 'package:UdemyClone/repository/StorageRepository.dart';
import 'package:UdemyClone/ultis/constants.dart' as Constants;
class RegisterBloc {
  RegisterRepository registerRepository = new RegisterRepository();
  // final StorageRepository storageRepository = new StorageRepository();

  final _loadingController = StreamController<bool>.broadcast();
  // PrefStorage _prefStorage = PrefStorage();
  Stream<bool> get isLoading => _loadingController.stream;

  RegisterBloc() {
    _loadingController.sink.add(false);
  }

  Future<bool> register(RegisterPayload payload) async {
    try {
      _loadingController.sink.add(true);
      return registerRepository.register(payload);
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
