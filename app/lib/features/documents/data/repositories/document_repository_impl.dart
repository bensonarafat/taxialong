import 'package:dartz/dartz.dart';
import 'package:taxialong/core/connection/network_info.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/core/services/local_storage.dart';
import 'package:taxialong/features/documents/data/datasources/document_remote_data_source.dart';
import 'package:taxialong/features/documents/data/models/complete_model.dart';
import 'package:taxialong/features/documents/data/models/document_model.dart';
import 'package:taxialong/features/documents/domain/repositories/document_repository.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final NetworkInfo networkInfo;
  final DocumentRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;
  DocumentRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localStorage,
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

  @override
  Future<Either<Failure, CompleteModel>> completeDocumentUpload() async {
    if (await networkInfo.isConnected) {
      try {
        CompleteModel completeModel =
            await remoteDataSource.completeUploadDocument();
        // switch user view to driver here if there is a sucess message
        if (completeModel.status) {
          localStorage.setDriverMode();
        }
        return Right(completeModel);
      } catch (_) {
        return Left(ServerFailure(message: 'There is a server Error!'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'Please check your internet connection'));
    }
  }
}
