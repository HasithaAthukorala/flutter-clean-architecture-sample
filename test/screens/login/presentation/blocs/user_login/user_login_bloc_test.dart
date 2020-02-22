import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/core/utils/constants.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/entities/login.dart';
import 'package:clean_architecture_with_bloc_app/core/usecases/fetch_token.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/usecases/login_user.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/presentation/blocs/user_login/bloc.dart';
import 'package:mockito/mockito.dart';

class MockLoginUser extends Mock implements LoginUser {}

class MockFetchToken extends Mock implements FetchToken {}

void main() {
  UserLoginBloc userLoginBloc;
  MockLoginUser mockLoginUser;
  MockFetchToken mockFetchToken;

  setUp(() {
    mockLoginUser = MockLoginUser();
    mockFetchToken = MockFetchToken();
    userLoginBloc = UserLoginBloc(
      loginUser: mockLoginUser,
      fetchToken: mockFetchToken,
    );
  });

  tearDown(() {
    userLoginBloc?.close();
  });

  final String tEmail = 'test@test.com';
  final String tPassword = 'test';

  test('should initial state equals to NotLoggedIn', () async {
    //assert
    expect(userLoginBloc.initialState, equals(NotLoggedState()));
  });

  group(
    'loginUser',
    () {
      test('should return an error if login is not successfull', () async {
        //arrange
        when(mockLoginUser(any)).thenAnswer((_) async => Left(ServerFailure()));

        //act
        userLoginBloc.add(LoginEvent(tEmail, tPassword));

        //assert
        expectLater(
          userLoginBloc,
          emitsInOrder(
            [
              NotLoggedState(),
              LoadingState(),
              ErrorState(message: LOGGING_ERROR)
            ],
          ),
        );
      });

      test(
        'should return LoggedState if login is successfull',
        () async {
          //arrange
          when(mockLoginUser(any))
              .thenAnswer((_) async => Right(Login(token: "1234")));

          //act
          userLoginBloc.add(LoginEvent(tEmail, tPassword));

          //assert
          expect(
            userLoginBloc,
            emitsInOrder(
              [
                NotLoggedState(),
                LoadingState(),
                LoggedState(login: Login(token: "1234"))
              ],
            ),
          );
        },
      );
    },
  );

  group('fetchToken', (){
    test('should return the token if exists', () async {
      //arrange
      when(mockFetchToken(any)).thenAnswer((_) async => Right(Login(token: "1234")));

      //act
      userLoginBloc.add(CheckLoginStatusEvent());

      //assert
      expect(
        userLoginBloc,
        emitsInOrder(
          [
            NotLoggedState(),
            LoadingState(),
            LoggedState(login: Login(token: "1234")),
          ],
        ),
      );
    });
  });
}
