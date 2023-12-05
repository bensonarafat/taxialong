import 'dart:convert';

import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';

class UserDataSource {
  final SecureStorage secureStorage;
  final dynamic client;

  UserDataSource({required this.secureStorage, required this.client});

  Future<UserModel> getUserData() async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.parse("${endpoint}auth/me");
    var response = await client.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return UserModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}
