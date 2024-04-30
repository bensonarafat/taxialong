import 'package:dio/dio.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';

class UserDataSource {
  final SecureStorage secureStorage;
  final Dio dio;

  UserDataSource({required this.secureStorage, required this.dio}) {
    dio.options.headers["Accept"] = "application/json";
  }

  Future<UserModel> getUserData() async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}auth/me";
    var response = await dio.get(
      url,
    );
    if (response.statusCode == 200) {
      var data = response.data;

      return UserModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}
