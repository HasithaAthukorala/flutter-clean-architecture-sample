import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ChangePasswordState extends Equatable {
  ChangePasswordState([List props = const <dynamic>[]]) : super(props);
}

class InitialState extends ChangePasswordState {}

class LoadingState extends ChangePasswordState {}

class SuccessfulState extends ChangePasswordState {}

class ErrorState extends ChangePasswordState {
  final String message;

  ErrorState(this.message);
}