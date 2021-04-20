import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/core/usecases/fetch_token.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/entities/login.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements LoginRepository {}

void main() {
  MockUserRepository mockUserRepository;
  FetchToken useCase;

  setUp((){
    mockUserRepository = MockUserRepository();
    useCase = FetchToken(repository: mockUserRepository);
  });

  final tToken = "123456789";

  test('should return the cached token if available', () async {
    //arrange
    when(mockUserRepository.fetchCachedToken()).thenAnswer((_) async => Right(Login(token: tToken)));

    //act
    final result = await useCase(TokenParams());

    //assert
    verify(mockUserRepository.fetchCachedToken());
    verifyNoMoreInteractions(mockUserRepository);
    expect(result, Right(Login(token: tToken)));
  });

  test('should ', () async {
    //arrange
    when(mockUserRepository.fetchCachedToken()).thenAnswer((_) async => Left(CacheFailure()));

    //act
    final result = await useCase(TokenParams());

    //assert
    expect(result, Left(CacheFailure()));
  });
}