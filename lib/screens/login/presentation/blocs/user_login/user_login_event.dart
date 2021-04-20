import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserLoginEvent extends Equatable {
  UserLoginEvent([List props = const <dynamic>[]]) : super(props);
}

class CheckLoginStatusEvent extends UserLoginEvent {}

class LoginEvent extends UserLoginEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class SkipLoginEvent extends UserLoginEvent {}
