import 'package:flutter/cupertino.dart';
import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeLocalDataSource {
  Future<bool> clearToken();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  final SharedPreferences sharedPreferences;

  HomeLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<bool> clearToken() async {
    bool removed = await sharedPreferences.remove(CACHED_TOKEN);
    if (!removed) {
      throw CacheException();
    }
    return removed;
  }
}
