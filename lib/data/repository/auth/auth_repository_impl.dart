import 'dart:async';

import 'package:boilerplate/data/network/apis/auth/auth_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  // api objects
  final AuthApi _authApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  AuthRepositoryImpl(this._authApi, this._sharedPrefsHelper);

  // Login:---------------------------------------------------------------------
  @override
  Future<void> login(String email, String password) async {
    return await _authApi.login(email, password).then((data) {
      // write to shared preference
      // _sharedPrefsHelper.saveAuthToken(data['token']);
    }).catchError((error) => throw error);
  }

  // Register:------------------------------------------------------------------
  @override
  Future<void> register(String email, String password) async {
    return await _authApi.register(email, password).then((data) {
      // write to shared preference
       //_sharedPrefsHelper.saveAuthToken(data['token']);
    }).catchError((error) => throw error);
  }

  // Logout:--------------------------------------------------------------------
  @override
  Future<void> logout() async {
    return await _authApi.logout().then((data) {
       //_sharedPrefsHelper.removeAuthToken();
    }).catchError((error) => throw error);
  }
}
