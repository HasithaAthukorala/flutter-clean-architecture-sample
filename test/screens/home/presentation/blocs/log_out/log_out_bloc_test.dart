import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/core/usecases/fetch_token.dart';
import 'package:clean_architecture_with_bloc_app/core/utils/constants.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/domain/usecases/logout_user.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/presentation/blocs/log_out/bloc.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/entities/login.dart';
import 'package:mockito/mockito.dart';

class MockLogOutUser extends Mock implements LogOutUser {}

class MockFetchToken extends Mock implements FetchToken {}

void main() {
  MockFetchToken mockFetchToken;
  MockLogOutUser mockLogOutUser;
  LogOutBloc logOutBloc;

  setUp(() {
    mockLogOutUser = MockLogOutUser();
    mockFetchToken = MockFetchToken();
    logOutBloc = LogOutBloc(
      logoutUser: mockLogOutUser,
      fetchToken: mockFetchToken,
    );
  });

  group('initialState', () {
    test('should return LoggedInState as the initial state', () async {
      //assert
      expect(logOutBloc.initialState, equals(LoggedInState()));
    });
  });

  group('mapEventToState', () {
    final String tToken = "123456789";

    test(
        'should return the correct sequence of states '
        'when everything is successfull', () async {
      //arrange
      when(mockFetchToken(any)).thenAnswer((_) async => Right(Login(
            token: tToken,
          )));
      when(mockLogOutUser(any)).thenAnswer((_) async => Right(true));

      //assert later
      expectLater(
          logOutBloc,
          emitsInOrder([
            LoggedInState(),
            LoadingState(),
            LoggedOutState(),
          ]));

      //act
      logOutBloc.add(UserLogOutEvent());
      await untilCalled(mockLogOutUser.call(any));

      //assert
      verify(mockFetchToken.call(TokenParams()));
      verify(mockLogOutUser.call(LogOutParams(token: tToken)));
    });

    test(
        'should return the correct sequence of states '
        'when logoutuser is not successfull', () async {
      //arrange
      when(mockFetchToken.call(any)).thenAnswer((_) async => Right(Login(
            token: tToken,
          )));
      when(mockLogOutUser.call(any))
          .thenAnswer((_) async => Left(ServerFailure()));

      //assert later
      expectLater(
          logOutBloc,
          emitsInOrder([
            LoggedInState(),
            LoadingState(),
            ErrorState(LOGGING_OUT_ERROR),
          ]));

      //act
      logOutBloc.add(UserLogOutEvent());
      await untilCalled(mockLogOutUser.call(any));

      //assert
      verify(mockFetchToken.call(TokenParams()));
      verify(mockLogOutUser.call(LogOutParams(token: tToken)));
    });

    test(
        'should return the correct sequence of states '
        'when fetch token is not successfull', () async {
      //arrange
      when(mockFetchToken.call(any))
          .thenAnswer((_) async => Left(CacheFailure()));

      //assert later
      expectLater(
          logOutBloc,
          emitsInOrder([
            LoggedInState(),
            LoadingState(),
            ErrorState(LOGGING_OUT_ERROR),
          ]));

      //act
      logOutBloc.add(UserLogOutEvent());
      await untilCalled(mockFetchToken.call(any));

      //assert
      verify(mockFetchToken.call(TokenParams()));
      verifyZeroInteractions(mockLogOutUser);
    });
  });
}
