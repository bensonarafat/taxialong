import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/usecases/usecase.dart';
import 'package:taxialong/features/documents/domain/entities/complete_entity.dart';
import 'package:taxialong/features/documents/domain/repositories/document_repository.dart';

class DocumentCompleteUsecase
    implements UseCase<CompleteEntity, CompleteParams> {
  DocumentRepository repository;
  DocumentCompleteUsecase({
    required this.repository,
  });
  @override
  Future<Either<Failure, CompleteEntity>> call(CompleteParams params) async {
    return await repository.completeDocumentUpload();
  }
}

class CompleteParams extends Equatable {
  @override
  List<Object?> get props => [];
}
