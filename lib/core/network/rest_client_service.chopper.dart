// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$RestClientService extends RestClientService {
  _$RestClientService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = RestClientService;

  Future<Response> loginUser(String jsonBody) {
    final $url = 'BASE_URL/tokens';
    final $headers = {'Content-type': 'application/json'};
    final $body = jsonBody;
    final $request =
        Request('POST', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> logoutUser(String jsonBody, String token) {
    final $url = 'BASE_URL/tokens';
    final $headers = {
      'Authorization': token,
      'Content-type': 'application/json'
    };
    final $body = jsonBody;
    final $request =
        Request('DELETE', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> changePassword(String jsonBody) {
    final $url = 'BASE_URL/create';
    final $headers = {'Content-type': 'application/json'};
    final $body = jsonBody;
    final $request =
        Request('PUT', $url, client.baseUrl, body: $body, headers: $headers);
    return client.send<dynamic, dynamic>($request);
  }
}
