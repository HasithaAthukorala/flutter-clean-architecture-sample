import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/domain/repositories/home_repository.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/domain/usecases/logout_user.dart';
import 'package:mockito/mockito.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  MockHomeRepository mockHomeRepository;
  LogOutUser logOutUser;

  setUp((){
    mockHomeRepository = MockHomeRepository();
    logOutUser = LogOutUser(repository: mockHomeRepository);
  });

  group('call', (){
    final String tToken = "123456789";

    test('should return true if logging out is successfull', () async {
      //arrange
      when(mockHomeRepository.logoutUser(any)).thenAnswer((_) async => Right(true));

      //act
      final result = await logOutUser(LogOutParams(token: tToken));

      //assert
      verify(mockHomeRepository.logoutUser(tToken));
      expect(result, Right(true));
    });

    test('should return a failure if logging out returns', () async {
      //arrange
      when(mockHomeRepository.logoutUser(any)).thenAnswer((_) async => Left(ServerFailure()));

      //act
      final result = await logOutUser(LogOutParams(token: tToken));

      //assert
      verify(mockHomeRepository.logoutUser(tToken));
      expect(result, Left(ServerFailure()));
    });
  });
}
