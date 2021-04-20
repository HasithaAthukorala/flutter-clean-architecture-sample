import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/core/network/network_info.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/data/datasources/login_local_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/data/datasources/login_remote_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/data/models/login_model.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/data/repositories/login_repository_impl.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/entities/login.dart';
import 'package:mockito/mockito.dart';

class MockUserRemoteDataSource extends Mock
    implements LoginRemoteDataSource {}

class MockUserLocalDataSource extends Mock
    implements LoginLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  LoginRepositoryImpl repository;
  MockUserRemoteDataSource mockRemoteDataSource;
  MockUserLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    mockLocalDataSource = MockUserLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LoginRepositoryImpl(
      networkInfo: mockNetworkInfo,
      localDataSource: mockLocalDataSource,
      remoteDataSource: mockRemoteDataSource,
    );
  });

  final String tEmail = "test@test.com";
  final String tPassword = "test";
  final LoginModel tLoginModel = LoginModel(token: "1234");
  final Login tLogin = tLoginModel;

  group("get user token", () {
    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      //act
      repository.loginUser(tEmail, tPassword);

      //assert
      verify(mockNetworkInfo.isConnected);
    });
  });

  group("device is online", () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('should return the token when the remote call is successfull', () async {
      //arrange
      when(mockRemoteDataSource.loginUser(tEmail, tPassword))
          .thenAnswer((_) async => tLoginModel);

      //act
      final result = await repository.loginUser(tEmail, tPassword);

      //assert
      verify(mockRemoteDataSource.loginUser(tEmail, tPassword));
      expect(result, equals(Right(tLogin)));
    });

    test('should cache the token locally when the remote call is successfull', () async {
      //arrange
      when(mockRemoteDataSource.loginUser(tEmail, tPassword))
          .thenAnswer((_) async => tLoginModel);

      //act
      await repository.loginUser(tEmail, tPassword);

      //assert
      verify(mockRemoteDataSource.loginUser(tEmail, tPassword));
      verify(mockLocalDataSource.cacheToken(tLoginModel));
    });

    test('should return a failure when the remote call is unsuccessfull', () async {
      //arrange
      when(mockRemoteDataSource.loginUser(tEmail, tPassword))
          .thenThrow(ServerException());

      //act
      final result = await repository.loginUser(tEmail, tPassword);

      //assert
      verify(mockRemoteDataSource.loginUser(tEmail, tPassword));
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group("device is offline", () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });

    test('should return a NoConnectionFailure if the device is offline', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) => Future.value(false));

      //act
      final result = await repository.loginUser(tEmail, tPassword);

      //assert
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, equals(Left(NoConnectionFailure())));
    });
  });
}
