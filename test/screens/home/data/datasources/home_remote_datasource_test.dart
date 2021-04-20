import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/network/rest_client_service.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/data/datasources/home_remote_datasource.dart';
import 'package:mockito/mockito.dart';

class MockRestClientService extends Mock implements RestClientService {}

void main() {
  MockRestClientService mockRestClientService;
  HomeRemoteDataSourceImpl dataSourceImpl;

  setUp(() {
    mockRestClientService = MockRestClientService();
    dataSourceImpl = HomeRemoteDataSourceImpl(
      restClientService: mockRestClientService,
    );
  });
  
  group('logOutUser', (){
    test('should log out if the response is 204', () async {
      //arrange
      when(mockRestClientService.logoutUser(any, any)).thenAnswer((_) async => Response(http.Response("", 204), ''));

      //act
      final result = await dataSourceImpl.logoutUser("1234");

      //assert
      verify(mockRestClientService.logoutUser(jsonEncode({
        'token': "1234",
      }),"1234"));
      expect(result, true);
    });

    test('should throw an exception if the response is not 204', () async {
      //arrange
      when(mockRestClientService.logoutUser(any, any)).thenAnswer((_) async => Response(http.Response("", 401), ''));

      //act
      final call = dataSourceImpl.logoutUser;

      //assert
      expect(() => call("1234"), throwsA(isA<ServerException>()));
    });
  });
}
