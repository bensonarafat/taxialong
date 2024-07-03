import 'package:dio/dio.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/auth/data/models/auth_model.dart';
import 'package:taxialong/features/auth/data/models/logout_model.dart';
import 'package:taxialong/features/auth/data/models/telephone_model.dart';
import 'package:taxialong/features/auth/data/models/verify_auth_model.dart';
import 'package:taxialong/features/auth/data/models/verify_otp_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> createAccount({required params});
  Future<TelephoneModel> telephone({required params});
  Future<VerifyOTPModel> verifyOTP({required params});
  Future<LogoutModel> logout();
  Future<AuthModel> authUser({required params});
  Future<VerifyAuthModel> verifyAuthModel();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  final SecureStorage secureStorage;

  AuthRemoteDataSourceImpl({
    required this.dio,
    required this.secureStorage,
  }) {
    dio.options.headers["Accept"] = "application/json";
  }

  @override
  Future<AuthModel> createAccount({required params}) async {
    var url = "${endpoint}auth/create-account";
    var response = await dio.post(
      url,
      data: {
        "firstname": params.firstname,
        "lastname": params.lastname,
        "telephone": params.telephone,
        "email": params.email,
        "uuid": params.uuid,
      },
    );

    if (response.statusCode == 200) {
      return AuthModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TelephoneModel> telephone({required params}) async {
    var url = "${endpoint}auth/telephone";
    var response = await dio.post(
      url,
      data: {"telephone": params.telephone},
    );

    if (response.statusCode == 200) {
      return TelephoneModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<VerifyOTPModel> verifyOTP({required params}) async {
    var url = "${endpoint}auth/otp-login";
    var response = await dio.post(
      url,
      data: {
        "otp": params.otp,
        "uuid": params.uuid,
        "telephone": params.telephone,
        "handler": params.handler,
      },
    );

    if (response.statusCode == 200) {
      return VerifyOTPModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<LogoutModel> logout() async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();

    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}auth/logout";
    var response = await dio.get(url);

    if (response.statusCode == 200) {
      return LogoutModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthModel> authUser({required params}) async {
    var url = "${endpoint}auth/otp-login";
    var response = await dio.post(
      url,
      data: {
        "telephone": params.telephone,
        "uuid": params.uuid,
        "otp": params.otp,
        "handler": params.handler,
      },
    );

    if (response.statusCode == 200) {
      return AuthModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<VerifyAuthModel> verifyAuthModel() async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();

    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}auth/verify-auth";
    var response = await dio.get(url);

    if (response.statusCode == 200) {
      return VerifyAuthModel.fromJson(response.data);
    } else {
      return VerifyAuthModel(
        status: false,
        message: 'Not LogIn',
        isDriver: null,
        isTrip: null,
      );
    }
  }
}
