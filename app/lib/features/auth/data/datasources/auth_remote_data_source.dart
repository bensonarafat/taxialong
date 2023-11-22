import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/features/auth/data/models/login_model_model.dart';
import 'package:taxialong/features/auth/data/models/logout_model.dart';
import 'package:taxialong/features/auth/data/models/register_model.dart';
import 'package:taxialong/features/auth/data/models/verify_otp_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> createAccount({required params});
  Future<RegisterModel> register({required params});
  Future<VerifyOTPModel> verifyOTP({required params});
  Future<LogoutModel> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final dynamic client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginModel> createAccount({required params}) async {
    var headers = {
      'Content-Type': 'application/json',
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
      return LoginModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<RegisterModel> register({required params}) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse("${endpoint}auth/register");
    var response = await client.post(
      url,
      body: {"telephone": params.telephone},
      headers: headers,
    );

    if (response.statusCode == 200) {
      return RegisterModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<VerifyOTPModel> verifyOTP({required params}) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse("${endpoint}auth/otp");
    var response = await client.post(
      url,
      body: {
        "otp": params.otp,
        "uuid": params.uuid,
        "telephone": params.telephone,
      },
      headers: headers,
    );

    if (response.statusCode == 200) {
      return VerifyOTPModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<LogoutModel> logout() async {
    String token = '';
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var url = Uri.parse("${endpoint}auth/logout");
    var response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      return LogoutModel.fromJson(response.json);
    } else {
      throw ServerException();
    }
  }
}
