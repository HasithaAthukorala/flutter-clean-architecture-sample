import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_bloc_app/core/error/failures.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/domain/repositories/change_password_repository.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/domain/usecases/change_password.dart';
import 'package:mockito/mockito.dart';

class MockChangePasswordRepository extends Mock
    implements ChangePasswordRepository {}

void main() {
  MockChangePasswordRepository mockRepository;
  ChangePassword usecase;

  setUp(() {
    mockRepository = MockChangePasswordRepository();
    usecase = ChangePassword(
      repository: mockRepository,
    );
  });

  group('call', () {
    final String tOldPassword = "123456789";
    final String tNewPassword = "987654321";

    test('should return true if everything is successfull', () async {
      //arrange
      when(mockRepository.changePassword(any, any))
          .thenAnswer((_) async => Right(true));

      //act
      final result = await usecase(ChangePasswordParams(
        oldPassword: tOldPassword,
        newPassword: tNewPassword,
      ));

      //assert
      verify(mockRepository.changePassword(tOldPassword, tNewPassword));
      verifyNoMoreInteractions(mockRepository);
      expect(result, Right(true));
    });

    test('should return failure if anything is wrong', () async {
      //arrange
      when(mockRepository.changePassword(any, any))
          .thenAnswer((_) async => Left(ServerFailure()));

      //act
      final result = await usecase(ChangePasswordParams(
        oldPassword: tOldPassword,
        newPassword: tNewPassword,
      ));

      //assert
      verify(mockRepository.changePassword(tOldPassword, tNewPassword));
      verifyNoMoreInteractions(mockRepository);
      expect(result, Left(ServerFailure()));
    });
  });
}
