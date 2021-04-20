import 'package:equatable/equatable.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/entities/login.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserLoginState extends Equatable {
  UserLoginState([List props = const <dynamic>[]]) : super(props);
}

class NotLoggedState extends UserLoginState {}

class LoadingState extends UserLoginState {}

class LoggedState extends UserLoginState {
  final Login login;

  LoggedState({@required this.login}) : super([login]);
}

class ErrorState extends UserLoginState {
  final String message;

  ErrorState({@required this.message}) : super([message]);
}
