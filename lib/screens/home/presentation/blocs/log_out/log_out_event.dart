import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LogOutEvent extends Equatable {
  LogOutEvent([List props = const <dynamic>[]]) : super(props);
}

class UserLogOutEvent extends LogOutEvent {}
