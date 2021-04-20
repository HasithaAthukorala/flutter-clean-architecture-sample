import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/network/rest_client_service.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/data/datasources/login_remote_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/data/models/login_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements RestClientService {}

void main() {
  MockHttpClient mockHttpClient;
  LoginRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = LoginRemoteDataSourceImpl(restClientService: mockHttpClient);
  });

  group('loginUser', () {
    final String tEmail = 'test@test.com';
    final String tPassword = 'test';
    final LoginModel tLoginModel = LoginModel(token: '1234');

    test('should return the User object if the status code is 200',
        () async {
      //arrange
      when(mockHttpClient.loginUser(jsonEncode({
        'email': tEmail,
        'password': tPassword,
      }))).thenAnswer(
          (_) async => Response(http.Response("", 200), fixture('user_login.json')));
      //act
      final result = await dataSourceImpl.loginUser(tEmail, tPassword);

      //assert
      verify(mockHttpClient.loginUser(jsonEncode({
        'email': tEmail,
        'password': tPassword,
      })));
      expect(result, equals(tLoginModel));
    });

    test('should throw an exception if the status code is not 200', () async {
      //arrange
      when(mockHttpClient.loginUser(jsonEncode({
        'email': tEmail,
        'password': tPassword,
      })))
          .thenAnswer((_) async => Response(http.Response("", 404), "Something went wrong"));

      //act
      final call = dataSourceImpl.loginUser;

      //assert
      expect(() => call(tEmail, tPassword), throwsA(isA<ServerException>()));
    });
  });
}
