import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/auth/data/models/user_model.dart';
import 'package:taxialong/features/profile/data/models/profile_model.dart';
import 'package:taxialong/features/profile/data/models/profile_photo_model.dart';
import 'package:taxialong/features/profile/domain/usecases/update_profile_usecase.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> updateProfile(ProfileParams params);
  Future<UserModel> getUserData();
  Future<ProfilePhotoModel> updateProfilePhoto(params);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SecureStorage secureStorage;
  final dynamic client;

  ProfileRemoteDataSourceImpl({
    required this.secureStorage,
    required this.client,
  });

  @override
  Future<ProfileModel> updateProfile(ProfileParams params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}account/update-profile");
    var response = await client.put(
      url,
      body: {
        "telephone": params.telephone,
        "firstname": params.firstname,
        "lastname": params.lastname,
        "email": params.email,
      },
      headers: headers,
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return ProfileModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
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

  @override
  Future<ProfilePhotoModel> updateProfilePhoto(params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.parse('${endpoint}account/upload-image');
    var request = http.MultipartRequest(
      'POST',
      url,
    );

    request.files.add(
      await http.MultipartFile.fromPath('file', params.path),
    );
    request.headers.addAll(headers);
    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      return ProfilePhotoModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}
