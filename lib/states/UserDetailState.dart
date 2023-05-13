
import 'package:UdemyClone/models/Course.dart';
import 'package:UdemyClone/models/DetailUser.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class UserDetailState{}

class UserDetailInitState extends UserDetailState{}

class UserDetailLoadingState extends UserDetailState{}

class UserDetailGetState extends UserDetailState{}

class UserDetailLoadedState extends UserDetailState{
  final DetailUser detailUser;
  UserDetailLoadedState({this.detailUser});
}
