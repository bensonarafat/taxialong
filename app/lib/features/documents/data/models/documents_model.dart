import 'package:taxialong/features/documents/domain/entities/documents_entity.dart';

class DocumentsModel extends DocumentsEntity {
  DocumentsModel({
    required super.file,
    required super.type,
    required super.id,
  });

  factory DocumentsModel.fromJson(Map<String, dynamic> json) {
    return DocumentsModel(
      file: json['file'],
      type: json['type'],
      id: json['id'],
    );
  }
}
