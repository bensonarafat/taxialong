import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/documents/domain/entities/document_entity.dart';
import 'package:taxialong/features/documents/domain/repositories/document_repository.dart';

class DocumentUploadUseCase implements UseCase<DocumentEntity, DocumentParams> {
  DocumentRepository repository;
  DocumentUploadUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, DocumentEntity>> call(DocumentParams params) async {
    return await repository.uploadDocument(params);
  }
}

class DocumentParams extends Equatable {
  final String type;
  final String file;

  const DocumentParams({required this.type, required this.file});

  @override
  List<Object?> get props => [type, file];
}
