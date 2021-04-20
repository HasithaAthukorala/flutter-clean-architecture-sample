import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_bloc_app/core/network/network_info.dart';
import 'package:mockito/mockito.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker {}

void main() {
  NetworkInfoImpl networkInfoImpl;
  MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl =
        NetworkInfoImpl(dataConnectionChecker: mockDataConnectionChecker);
  });
  
  group('is Connected', (){
    setUp((){
      when(mockDataConnectionChecker.hasConnection).thenAnswer((_) async => true);
    });

    test('should forward the connection to the desired method', () async {
      //act
      final result = await networkInfoImpl.isConnected;

      //assert
      verify(mockDataConnectionChecker.hasConnection);
      expect(result, true);
    });
  });
}
