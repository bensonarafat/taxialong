import 'package:dio/dio.dart';
import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/documents/data/models/complete_model.dart';
import 'package:taxialong/features/documents/data/models/document_model.dart';
import 'package:taxialong/features/documents/data/models/documents_model.dart';
import 'package:taxialong/features/documents/domain/usecases/document_upload_usecase.dart';

abstract class DocumentRemoteDataSource {
  Future<DocumentModel> uploadDocument(DocumentParams params);
  Future<CompleteModel> completeUploadDocument();
  Future<List<DocumentsModel>> getDocuments();
}

class DocumentRemoteDataSourceImpl implements DocumentRemoteDataSource {
  final Dio dio;
  final SecureStorage secureStorage;

  DocumentRemoteDataSourceImpl(
      {required this.dio, required this.secureStorage}) {
    dio.options.headers["Accept"] = "application/json";
  }

  @override
  Future<DocumentModel> uploadDocument(DocumentParams params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';

    var url = '${endpoint}driver/document/upload';
    Future<FormData> createFormData() async {
      return FormData.fromMap({
        'type': params.type,
        'file': await MultipartFile.fromFile(params.file),
      });
    }

    var response = await dio.post(url, data: await createFormData());

    if (response.statusCode == 200) {
      return DocumentModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CompleteModel> completeUploadDocument() async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}driver/document/complete";
    var response = await dio.get(
      url,
    );

    if (response.statusCode == 200) {
      return CompleteModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DocumentsModel>> getDocuments() async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    dio.options.headers["Authorization"] = 'Bearer $token';
    var url = "${endpoint}driver/document";
    var response = await dio.get(
      url,
    );

    if (response.statusCode == 200) {
      var data = response.data;
      List<dynamic> jsonresponse = data['data'];
      List<DocumentsModel> list =
          jsonresponse.map((item) => DocumentsModel.fromJson(item)).toList();
      return list;
    } else {
      throw ServerException();
    }
  }
}
