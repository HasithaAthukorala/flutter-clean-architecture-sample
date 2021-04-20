import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/utils/constants.dart';
import 'package:clean_architecture_with_bloc_app/screens/login/data/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LoginLocalDataSource {
  Future<LoginModel> getLastToken();
  Future<void> cacheToken(LoginModel loginModel);
}

class LoginLocalDataSourceImpl extends LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheToken(LoginModel loginModel) {
    return sharedPreferences.setString(CACHED_TOKEN, jsonEncode(loginModel));
  }

  @override
  Future<LoginModel> getLastToken() {
    String jsonStr = sharedPreferences.getString(CACHED_TOKEN);
    if (jsonStr == null) {
      throw CacheException();
    }
    return Future.value(LoginModel.fromJson(jsonDecode(jsonStr)));
  }
}
