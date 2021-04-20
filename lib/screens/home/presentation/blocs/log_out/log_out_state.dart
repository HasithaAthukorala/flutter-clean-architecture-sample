import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LogOutState extends Equatable {
  LogOutState([List props = const <dynamic>[]]) : super(props);
}

class LoggedInState extends LogOutState {}

class LoggedOutState extends LogOutState {}

class LoadingState extends LogOutState {}

class ErrorState extends LogOutState {
  final String message;

  ErrorState(this.message);
}
