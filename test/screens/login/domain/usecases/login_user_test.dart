import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/entities/login.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/repositories/login_repository.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/usecases/login_user.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements LoginRepository {}

void main() {
  MockUserRepository mockUserRepository;
  LoginUser useCase;

  setUp((){
    mockUserRepository = MockUserRepository();
    useCase = LoginUser(repository: mockUserRepository);
  });

  final tEmail = "test@test.com";
  final Login tUser = Login(token: "");

  test('should return a User object with relevant email and token', () async {
    //arrange
    when(mockUserRepository.loginUser(tEmail, "test")).thenAnswer((_) async => Right(tUser));

    //act
    final result = await useCase(LoginParams(email: tEmail, password: "test"));

    //assert
    expect(result, Right(tUser));
    verify(mockUserRepository.loginUser(tEmail, "test"));
    verifyNoMoreInteractions(mockUserRepository);
  });
}