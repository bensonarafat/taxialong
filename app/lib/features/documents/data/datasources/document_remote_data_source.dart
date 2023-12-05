import 'dart:convert';
import 'package:http/http.dart' as http;
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
  final dynamic client;
  final SecureStorage secureStorage;

  DocumentRemoteDataSourceImpl(
      {required this.client, required this.secureStorage});

  @override
  Future<DocumentModel> uploadDocument(DocumentParams params) async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var url = Uri.parse('${endpoint}driver/document/upload');
    var request = http.MultipartRequest(
      'POST',
      url,
    );
    request.fields.addAll(
      {'type': params.type},
    );
    request.files.add(
      await http.MultipartFile.fromPath('file', params.file),
    );
    request.headers.addAll(headers);
    var response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return DocumentModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<CompleteModel> completeUploadDocument() async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}driver/document/complete");
    var response = await client.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return CompleteModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<DocumentsModel>> getDocuments() async {
    final token = await secureStorage.getToken();
    if (token == null) throw ServerException();
    var headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var url = Uri.parse("${endpoint}driver/document");
    var response = await client.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> jsonresponse = data['data'];
      List<DocumentsModel> list =
          jsonresponse.map((item) => DocumentsModel.fromJson(item)).toList();
      return list;
    } else {
      throw ServerException();
    }
  }
}
