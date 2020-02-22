import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/utils/constants.dart';
import 'package:clean_architecture_with_bloc_app/screens/home/data/datasources/home_local_datasource.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences;
  HomeLocalDataSource localDataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSource = HomeLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('clearToken', (){
    test('should return true when removing is successful', () async {
      //arrange
      when(mockSharedPreferences.remove(any)).thenAnswer((_) => Future.value(true));

      //act
      final result = await localDataSource.clearToken();

      //assert
      verify(mockSharedPreferences.remove(CACHED_TOKEN));
      verifyNoMoreInteractions(mockSharedPreferences);
      expect(result, true);
    });

    test('should throw a cache exception when the task is not successfull', () async {
      //arrange
      when(mockSharedPreferences.remove(any)).thenThrow(CacheException());

      //act
      final call = localDataSource.clearToken;

      //assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });
}
