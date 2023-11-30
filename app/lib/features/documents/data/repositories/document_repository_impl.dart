import 'package:dartz/dartz.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/documents/data/datasources/document_remote_data_source.dart';
import 'package:taxialong/features/documents/data/models/document_model.dart';
import 'package:taxialong/features/documents/domain/repositories/document_repository.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final NetworkInfo networkInfo;
  final DocumentRemoteDataSource remoteDataSource;
  DocumentRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, DocumentModel>> uploadDocument(params) async {
    if (await networkInfo.isConnected) {
      try {
        DocumentModel documentModel =
            await remoteDataSource.uploadDocument(params);

        return Right(documentModel);
      } catch (_) {
        return Left(ServerFailure(message: 'There is a server Error!'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }
}
