import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/network/rest_client_service.dart';
import 'package:clean_architecture_with_bloc_app/screens/change_password/data/datasources/change_password_remote_datasource.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockRestClientService extends Mock implements RestClientService {}

void main() {
  MockRestClientService mockRestClientService;
  ChangePasswordRemoteDataSource remoteDataSource;

  setUp(() {
    mockRestClientService = MockRestClientService();
    remoteDataSource = ChangePasswordRemoteDataSourceImpl(
      restClientService: mockRestClientService,
    );
  });

  group('changePassword', () {
    final String tOldPassword = "123456789";
    final String tNewPassword = "987654321";

    test('should return true when the task is successful', () async {
      //arrange
      when(mockRestClientService.changePassword(any))
          .thenAnswer((_) async => Response(http.Response("", 204), ''));

      //act
      final result =
          await remoteDataSource.changePassword(tOldPassword, tNewPassword);

      //assert
      verify(mockRestClientService.changePassword(jsonEncode({
        'oldPassword': tOldPassword,
        'newPassword': tNewPassword,
      })));
      verifyNoMoreInteractions(mockRestClientService);
      expect(result, equals(true));
    });

    test('should return a server exception if it fails', () async {
      //arrange
      when(mockRestClientService.changePassword(any))
          .thenThrow(ServerException());

      //act
      final call =
      remoteDataSource.changePassword;

      //assert
      expect(() => call(tOldPassword, tNewPassword), throwsA(isA<ServerException>()));
    });
  });
}
