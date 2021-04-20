import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/core/network/network_info.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/data/datasources/change_password_local_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/data/datasources/change_password_remote_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/data/repositories/change_password_repository_impl.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/domain/repositories/change_password_repository.dart';
import 'package:mockito/mockito.dart';

class MockLocalDataSource extends Mock
    implements ChangePasswordLocalDataSource {}

class MockRemoteDataSource extends Mock
    implements ChangePasswordRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockLocalDataSource mockLocalDataSource;
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;
  ChangePasswordRepository repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ChangePasswordRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('changePassword', () {
    final String tOldPassword = "123456789";
    final String tNewPassword = "987654321";

    test('should return true is everything is successful', () async {
      //arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((_) async => Future.value(true));
      when(mockRemoteDataSource.changePassword(any, any))
          .thenAnswer((_) async => Future.value(true));

      //act
      final result =
          await repository.changePassword(tOldPassword, tNewPassword);

      //assert
      verify(mockNetworkInfo.isConnected);
      expect(result, equals(Right(true)));
    });

    test('should return server failure if a server exception is thrown',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((_) async => Future.value(true));
      when(mockRemoteDataSource.changePassword(any, any))
          .thenThrow(ServerException());

      //act
      final result =
          await repository.changePassword(tOldPassword, tNewPassword);

      //assert
      verify(mockNetworkInfo.isConnected);
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return no connection failure if the device is offline',
        () async {
      //arrange
      when(mockNetworkInfo.isConnected)
          .thenAnswer((_) async => Future.value(false));

      //act
      final result =
          await repository.changePassword(tOldPassword, tNewPassword);

      //assert
      verify(mockNetworkInfo.isConnected);
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, equals(Left(NoConnectionFailure())));
    });
  });
}
