import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/data/models/login_model.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/domain/entities/login.dart';

import '../../../../fixtures/fixture_reader.dart';

void main(){
  LoginModel tLoginModel = LoginModel(token: "1234");
  test('should be a subclass of User entity', () async {
    //assert
    expect(tLoginModel, isA<Login>());
  });

  group("fromJson", (){
    test('should return a valid model when a valid JSON is given', () async {
      //arrange
      Map<String, dynamic> jsonMap = jsonDecode(fixture("user_login.json"));

      //act
      final result = LoginModel.fromJson(jsonMap);

      //assert
      expect(result, equals(tLoginModel));
    });

    test('should return a null token when a token is not given in the JSON', () async {
      //arrange
      Map<String, dynamic> jsonMap = jsonDecode(fixture("user_login_null_token.json"));

      //act
      final result = LoginModel.fromJson(jsonMap);

      //assert
      expect(result, equals(LoginModel(token: null)));
    });
  });

  group("toJson", (){
    test('should return a valid map when called the toJson method', () async {
      //act
      final result = tLoginModel.toJson();

      //assert
      final expectedMap = {
        'token': '1234'
      };
      expect(result, equals(expectedMap));
    });
  });
}