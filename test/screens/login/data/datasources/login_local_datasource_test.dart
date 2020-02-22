import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/utils/constants.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/data/datasources/login_local_datasource.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/data/models/login_model.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences;
  LoginLocalDataSourceImpl dataSourceImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl =
        LoginLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getLastToken', () {
    final LoginModel tLoginModel =
        LoginModel.fromJson(jsonDecode(fixture('user_login.json')));

    test('should return last stored token (cached)', () async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('user_login.json'));

      //act
      final result = await dataSourceImpl.getLastToken();

      //assert
      verify(mockSharedPreferences.getString(CACHED_TOKEN));
      expect(result, tLoginModel);
    });

    test('should return a Cache Failure when there is no stored token',
        () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenThrow(CacheException());

      //act
      final call = dataSourceImpl.getLastToken;

      //assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheToken', () {
    final LoginModel tLoginModel = LoginModel(token: '123456');

    test('should store the token', () async {
      //act
      dataSourceImpl.cacheToken(tLoginModel);

      //assert
      verify(mockSharedPreferences.setString(
          CACHED_TOKEN, jsonEncode(tLoginModel)));
    });
  });
}
