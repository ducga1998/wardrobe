import 'dart:async';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/rest_client.dart';

class AuthApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  AuthApi(this._dioClient, this._restClient);

  /// Register users
  Future<dynamic> register(String email, String password) async {
    try {
      final res = await _dioClient.dio.post(Endpoints.register, data: {
        "email": email,
        "password": password,
      });
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Login users
  Future<dynamic> login(String email, String password) async {
    try {
      final res = await _dioClient.dio.post(Endpoints.login, data: {
        "email": email,
        "password": password,
      });
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Logout users
  Future<dynamic> logout() async {
    try {
      final res = await _dioClient.dio.post(Endpoints.logout);
      return res.data;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
