import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/core/network/network_info.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/data/datasources/home_local_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/data/datasources/home_remote_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/data/repositories/home_repository_impl.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/domain/repositories/home_repository.dart';
import 'package:mockito/mockito.dart';

class MockLocalDataSource extends Mock implements HomeLocalDataSource {}

class MockRemoteDataSource extends Mock implements HomeRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockLocalDataSource mockLocalDataSource;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;
  HomeRepository repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = HomeRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('logoutUser', (){
    final String tToken = "123456789";

    test('should return true if successfully logged out', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) => Future.value(true));
      when(mockRemoteDataSource.logoutUser(any)).thenAnswer((_) => Future.value(true));
      when(mockLocalDataSource.clearToken()).thenAnswer((_) => Future.value(true));

      //act
      final result = await repository.logoutUser(tToken);

      //assert
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.logoutUser(tToken));
      verify(mockLocalDataSource.clearToken());
      verifyNoMoreInteractions(mockRemoteDataSource);
      expect(result, Right(true));
    });

    test('should return an cache failure if getting cached token is unsuccessful', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) => Future.value(true));
      when(mockRemoteDataSource.logoutUser(any)).thenAnswer((_) => Future.value(true));
      when(mockLocalDataSource.clearToken()).thenThrow(CacheException());

      //act
      final result = await repository.logoutUser(tToken);

      //assert
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.logoutUser(tToken));
      verify(mockLocalDataSource.clearToken());
      verifyNoMoreInteractions(mockRemoteDataSource);
      expect(result, Left(CacheFailure()));
    });

    test('should return a server failure if logout user is not successfull', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) => Future.value(true));
      when(mockRemoteDataSource.logoutUser(any)).thenThrow(ServerException());

      //act
      final result = await repository.logoutUser(tToken);

      //assert
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.logoutUser(tToken));
      verifyZeroInteractions(mockLocalDataSource);
      verifyNoMoreInteractions(mockRemoteDataSource);
      expect(result, Left(ServerFailure()));
    });

    test('should return a no connection failure if device is offline', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) => Future.value(false));

      //act
      final result = await repository.logoutUser(tToken);

      //assert
      verify(mockNetworkInfo.isConnected);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockLocalDataSource);
      expect(result, Left(NoConnectionFailure()));
    });
  });
}
