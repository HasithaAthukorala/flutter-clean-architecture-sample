import "dart:async";

import 'package:chopper/chopper.dart';
import 'package:clean_architecture_with_bloc_app/core/utils/constants.dart';

part "rest_client_service.chopper.dart";

@ChopperApi(baseUrl: API_BASE_URL)
abstract class RestClientService extends ChopperService {
  static RestClientService create([ChopperClient client]) =>
      _$RestClientService(client);

  @Post(path: LOGIN_USER, headers: {'Content-type': 'application/json'})
  Future<Response> loginUser(@Body() String jsonBody);

  @Delete(path: LOGIN_USER, headers: {'Content-type': 'application/json'})
  Future<Response> logoutUser(
      @Body() String jsonBody, @Header("Authorization") String token);

  @Put(path: CREATE_USER, headers: {'Content-type': 'application/json'})
  Future<Response> changePassword(@Body() String jsonBody);
}
