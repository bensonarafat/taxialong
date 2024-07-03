import 'package:dio/dio.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/data/models/account_switch_model.dart';
import 'package:taxialong/core/data/models/seats_model.dart';
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
  Future<List<SeatsModel>> getSeats();
}

class SettingsRemoteDataSourceImp implements SettingsRemoteDataSource {
  final SecureStorage secureStorage;
  final Dio dio;

  SettingsRemoteDataSourceImp({
    required this.secureStorage,
    required this.dio,
  }) {
    dio.options.headers["Accept"] = "application/json";
  }

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
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}account/switch/$role";
    var response = await dio.get(
      url,
    );
    if (response.statusCode == 200) {
      var data = response.data;
      return AccountSwitchModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TerminalModel>> getTerminals() async {
    final token = await secureStorage.getToken();

    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}terminal";
    var response = await dio.get(
      url,
    );
    if (response.statusCode == 200) {
      var data = response.data;
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
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}account/update-settings";

    var response = await dio.post(
      url,
      data: {
        "pointa": params.pointa,
        "pointb": params.pointb,
        "payment_method": params.paymentMethod,
      },
    );

    if (response.statusCode == 200) {
      var data = response.data;
      return SettingsUpdateModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SeatsModel>> getSeats() async {
    var url = "${endpoint}seat";
    var response = await dio.get(
      url,
    );
    if (response.statusCode == 200) {
      var data = response.data;
      List<dynamic> jsonresponse = data;
      List<SeatsModel> list =
          jsonresponse.map((item) => SeatsModel.fromJson(item)).toList();
      return list;
    } else {
      throw ServerException();
    }
  }
}
