import 'dart:convert';

import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/auth/data/models/auth_model.dart';
import 'package:taxialong/features/auth/data/models/logout_model.dart';
import 'package:taxialong/features/auth/data/models/telephone_model.dart';
import 'package:taxialong/features/auth/data/models/verify_otp_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> createAccount({required params});
  Future<TelephoneModel> telephone({required params});
  Future<VerifyOTPModel> verifyOTP({required params});
  Future<LogoutModel> logout();
  Future<AuthModel> authUser({required params});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final dynamic client;
  final SecureStorage secureStorage;

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.secureStorage,
  });

  @override
  Future<AuthModel> createAccount({required params}) async {
    var headers = {
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}auth/create-account");
    var response = await client.post(
      url,
      body: {
        "firstname": params.firstname,
        "lastname": params.lastname,
        "telephone": params.telephone,
        "email": params.email,
        "uuid": params.uuid,
      },
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return AuthModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TelephoneModel> telephone({required params}) async {
    var url = Uri.parse("${endpoint}auth/telephone");
    var response = await client.post(
      url,
      body: {"telephone": params.telephone},
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return TelephoneModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<VerifyOTPModel> verifyOTP({required params}) async {
    var headers = {
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}auth/otp-login");
    var response = await client.post(
      url,
      body: {
        "otp": params.otp,
        "uuid": params.uuid,
        "telephone": params.telephone,
        "handler": params.handler,
      },
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return VerifyOTPModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<LogoutModel> logout() async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}auth/logout");
    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return LogoutModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthModel> authUser({required params}) async {
    var headers = {
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}auth/otp-login");
    var response = await client.post(
      url,
      body: {
        "telephone": params.telephone,
        "uuid": params.uuid,
        "otp": params.otp,
        "handler": params.handler,
      },
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return AuthModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}
