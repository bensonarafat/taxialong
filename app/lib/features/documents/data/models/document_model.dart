import 'package:taxialong/features/documents/domain/entities/document_entity.dart';

class DocumentModel extends DocumentEntity {
  DocumentModel(
      {required super.status,
      required super.message,
      required super.file,
      required super.type,
      required super.id});

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      status: json['status'],
      message: json['message'],
      file: json['data']['file'],
      type: json['data']['type'],
      id: json['data']['id'],
    );
  }
}
