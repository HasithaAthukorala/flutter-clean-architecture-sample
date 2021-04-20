import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ChangePasswordLocalDataSource {
  //TODO: Add use cases
}

class ChangePasswordLocalDataSourceImpl extends ChangePasswordLocalDataSource {
  final SharedPreferences sharedPreferences;

  ChangePasswordLocalDataSourceImpl({@required this.sharedPreferences});
}