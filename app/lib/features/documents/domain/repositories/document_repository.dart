import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/documents/domain/entities/complete_entity.dart';
import 'package:taxialong/features/documents/domain/entities/document_entity.dart';
import 'package:taxialong/features/documents/domain/entities/documents_entity.dart';

abstract class DocumentRepository {
  Future<Either<Failure, DocumentEntity>> uploadDocument(params);
  Future<Either<Failure, CompleteEntity>> completeDocumentUpload();
  Future<Either<Failure, List<DocumentsEntity>>> getDocuments();
}
