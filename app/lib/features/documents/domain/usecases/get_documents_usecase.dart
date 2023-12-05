import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/documents/domain/entities/documents_entity.dart';
import 'package:taxialong/features/documents/domain/repositories/document_repository.dart';

class GetDocumentsUseCase
    implements UseCase<List<DocumentsEntity>, DocumentsParams> {
  DocumentRepository repository;
  GetDocumentsUseCase({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<DocumentsEntity>>> call(
      DocumentsParams params) async {
    return await repository.getDocuments();
  }
}

class DocumentsParams extends Equatable {
  @override
  List<Object?> get props => [];
}
