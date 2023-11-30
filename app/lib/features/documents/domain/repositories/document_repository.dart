import 'package:dartz/dartz.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/documents/domain/entities/document_entity.dart';

abstract class DocumentRepository {
  Future<Either<Failure, DocumentEntity>> uploadDocument(params);
}
