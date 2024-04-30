import 'package:dio/dio.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/profile/data/models/profile_model.dart';
import 'package:taxialong/features/profile/data/models/profile_photo_model.dart';
import 'package:taxialong/features/profile/domain/usecases/update_profile_usecase.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel> updateProfile(ProfileParams params);
  Future<ProfilePhotoModel> updateProfilePhoto(params);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SecureStorage secureStorage;
  final Dio dio;

  ProfileRemoteDataSourceImpl({
    required this.secureStorage,
    required this.dio,
  }) {
    dio.options.headers["Accept"] = "application/json";
  }

  @override
  Future<ProfileModel> updateProfile(ProfileParams params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}account/update-profile";
    var response = await dio.put(
      url,
      data: {
        "telephone": params.telephone,
        "firstname": params.firstname,
        "lastname": params.lastname,
        "email": params.email,
      },
    );
    if (response.statusCode == 200) {
      var data = response.data;
      return ProfileModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProfilePhotoModel> updateProfilePhoto(params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = '${endpoint}account/upload-image';

    Future<FormData> createFormData() async {
      return FormData.fromMap({
        'file': await MultipartFile.fromFile(params.path),
      });
    }

    var response = await dio.post(url, data: await createFormData());

    if (response.statusCode == 200) {
      var data = response.data;

      return ProfilePhotoModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}
