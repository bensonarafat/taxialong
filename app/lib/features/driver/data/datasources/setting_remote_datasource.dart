import 'dart:convert';

import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/data/models/account_switch_model.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/core/services/secure_storage.dart';

abstract class DriverHomeRemoteDataSource {
  Future<AccountSwitchModel> switchAccount();
}

class DriverHomeRemoteDataSourceImpl implements DriverHomeRemoteDataSource {
  final SecureStorage secureStorage;
  final dynamic client;

  DriverHomeRemoteDataSourceImpl({
    required this.secureStorage,
    required this.client,
  });

  @override
  Future<AccountSwitchModel> switchAccount() async {
    final token = await secureStorage.getToken();
    UserModel? usermodel = await secureStorage.getUserData();
    String role = "driver";
    if (usermodel != null) {
      String xrole = usermodel.role;
      if (xrole == "driver") {
        role = "rider";
      } else {
        role = "driver";
      }
    }
    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}account/switch/$role");
    var response = await client.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return AccountSwitchModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}
