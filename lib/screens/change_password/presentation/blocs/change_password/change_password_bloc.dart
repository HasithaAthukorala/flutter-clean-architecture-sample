import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:clean_architecture_with_bloc_app/core/utils/constants.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/domain/usecases/change_password.dart';

import 'bloc.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final ChangePassword changePassword;

  ChangePasswordBloc({@required this.changePassword});

  @override
  ChangePasswordState get initialState => InitialState();

  @override
  Stream<ChangePasswordState> mapEventToState(
      ChangePasswordEvent event) async* {
    if (event is PasswordChangeEvent) {
      yield LoadingState();
      final result = await changePassword(ChangePasswordParams(
        oldPassword: event.oldPassword,
        newPassword: event.newPassword,
      ));
      yield* result.fold((failure) async* {
        yield ErrorState(CHANGE_PASSWORD_ERROR);
      }, (success) async* {
        yield SuccessfulState();
      });
    }
  }
}
