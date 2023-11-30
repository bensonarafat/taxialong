import 'dart:convert';

import 'package:taxialong/core/constants/constants.dart';
import 'package:taxialong/core/error/execptions.dart';
import 'package:taxialong/core/services/secure_storage.dart';
import 'package:taxialong/features/documents/data/models/document_model.dart';
import 'package:taxialong/features/documents/domain/usecases/document_upload_usecase.dart';

abstract class DocumentRemoteDataSource {
  Future<DocumentModel> uploadDocument(DocumentParams params);
}

class DocumentRemoteDataSourceImpl implements DocumentRemoteDataSource {
  final dynamic client;
  final SecureStorage secureStorage;

  DocumentRemoteDataSourceImpl(
      {required this.client, required this.secureStorage});

  @override
  Future<DocumentModel> uploadDocument(DocumentParams params) async {
    var headers = {'Accept': 'application/json'};
    var request = client.MultipartRequest(
      'POST',
      Uri.parse('${endpoint}driver/document/upload'),
    );
    request.fields.addAll(
      {'type': params.type},
    );
    request.files.add(
      await client.MultipartFile.fromPath('file', params.file),
    );
    request.headers.addAll(headers);
    var response = await request.send();
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return DocumentModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}
