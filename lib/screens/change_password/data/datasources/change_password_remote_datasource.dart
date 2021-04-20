import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:clean_architecture_with_bloc_app/core/error/exceptions.dart';
import 'package:clean_architecture_with_bloc_app/core/network/rest_client_service.dart';

abstract class ChangePasswordRemoteDataSource {
  Future<bool> changePassword(String oldPassword, String newPassword);
}

class ChangePasswordRemoteDataSourceImpl extends ChangePasswordRemoteDataSource {
  final RestClientService restClientService;

  ChangePasswordRemoteDataSourceImpl({@required this.restClientService});

  @override
  Future<bool> changePassword(String oldPassword, String newPassword) async {
    final response = await restClientService.changePassword(
      jsonEncode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    );
    if (response.statusCode != 204) {
      throw ServerException();
    }
    return true;
  }
}
