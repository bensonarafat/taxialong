import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/documents/domain/entities/document_entity.dart';
import 'package:taxialong/features/documents/domain/usecases/document_upload_usecase.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentUploadUseCase documentUploadUseCase;
  DocumentBloc({
    required this.documentUploadUseCase,
  }) : super(DocumentInitialState()) {
    on<DocumentEvent>((event, emit) async {
      if (event is DocumentUploadEvent) {
        emit(DocumentLoadingState());
        final failureOrUploadDocument =
            await documentUploadUseCase(DocumentParams(
          file: event.path,
          type: event.type,
        ));

        emit(failureOrUploadDocument.fold(
            (failure) =>
                DocumentErrorState(message: _mapFailureToMessage(failure)),
            (documentEntity) =>
                DocumentUploadedState(documentEntity: documentEntity)));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'There was a server error!';
      case CacheFailure:
        return 'Cache Failure';
      case NetworkFailure:
        return 'Network error, check your internet connection';
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
