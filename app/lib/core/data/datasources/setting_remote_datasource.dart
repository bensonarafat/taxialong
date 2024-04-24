import 'dart:convert';

import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/data/models/account_switch_model.dart';
import 'package:taxialong/core/data/models/settings_update_model.dart';
import 'package:taxialong/core/data/models/user_model.dart';
import 'package:taxialong/core/domain/usecases/update_settings_usecase.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/core/data/models/terminal_model.dart';

abstract class SettingsRemoteDataSource {
  Future<AccountSwitchModel> switchAccount();
  Future<List<TerminalModel>> getTerminals();
  Future<SettingsUpdateModel> updateSettings(SettingsParams params);
}

class SettingsRemoteDataSourceImp implements SettingsRemoteDataSource {
  final SecureStorage secureStorage;
  final dynamic client;

  SettingsRemoteDataSourceImp({
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

  @override
  Future<List<TerminalModel>> getTerminals() async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}terminal");
    var response = await client.get(
      url,
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> jsonresponse = data['data'];
      List<TerminalModel> list =
          jsonresponse.map((item) => TerminalModel.fromJson(item)).toList();
      return list;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<SettingsUpdateModel> updateSettings(SettingsParams params) async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}account/update-settings");

    var response = await client.post(
      url,
      headers: headers,
      body: {
        "pointa": params.pointa,
        "pointb": params.pointb,
        "payment_method": params.paymentMethod,
        "ride_class": jsonEncode(params.selectedClass),
      },
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return SettingsUpdateModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}
