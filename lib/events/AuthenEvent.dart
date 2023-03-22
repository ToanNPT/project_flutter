import 'package:UdemyClone/models/LoginPayload.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class AuthenEvent extends Equatable {
  const AuthenEvent();
}

class LoginEvent extends AuthenEvent {
  final LoginPayload loginPayload;

  LoginEvent(this.loginPayload);

  @override
  List<Object> get props => [];
}