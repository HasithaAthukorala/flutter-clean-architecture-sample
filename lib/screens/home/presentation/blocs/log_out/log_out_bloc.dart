import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:clean_architecture_with_bloc_app/core/usecases/fetch_token.dart';
import 'package:clean_architecture_with_bloc_app/core/utils/constants.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/domain/usecases/logout_user.dart';

import 'bloc.dart';

class LogOutBloc extends Bloc<LogOutEvent, LogOutState> {
  final FetchToken fetchToken;
  final LogOutUser logoutUser;

  LogOutBloc({@required this.fetchToken, @required this.logoutUser});

  @override
  LogOutState get initialState => LoggedInState();

  @override
  Stream<LogOutState> mapEventToState(LogOutEvent event) async* {
    if (event is UserLogOutEvent) {
      yield LoadingState();
      final token = await fetchToken(TokenParams());
      yield* token.fold((failure) async* {
        yield ErrorState(LOGGING_OUT_ERROR);
      }, (success) async* {
        final result = await logoutUser(LogOutParams(token: success.token));
        yield* result.fold((failure) async* {
          yield ErrorState(LOGGING_OUT_ERROR);
        }, (success) async* {
          yield LoggedOutState();
        });
      });
    }
  }
}
