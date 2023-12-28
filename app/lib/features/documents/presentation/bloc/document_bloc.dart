import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/utils/helpers.dart';
import 'package:taxialong/features/documents/domain/entities/complete_entity.dart';
import 'package:taxialong/features/documents/domain/entities/document_entity.dart';
import 'package:taxialong/features/documents/domain/entities/documents_entity.dart';
import 'package:taxialong/features/documents/domain/usecases/document_complete_usecase.dart';
import 'package:taxialong/features/documents/domain/usecases/document_upload_usecase.dart';
import 'package:taxialong/features/documents/domain/usecases/get_documents_usecase.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentUploadUseCase documentUploadUseCase;
  DocumentCompleteUsecase documentCompleteUsecase;
  GetDocumentsUseCase getDocumentsUseCase;
  DocumentBloc({
    required this.documentUploadUseCase,
    required this.documentCompleteUsecase,
    required this.getDocumentsUseCase,
  }) : super(DocumentInitialState()) {
    on<DocumentUploadEvent>((event, emit) => documentUploadEvent(event, emit));
    on<DocumentUploadCompleteEvent>(
        (event, emit) => documentUploadCompleteEvent(event, emit));
    on<DocumentFetchDocuments>(
        (event, emit) => documentFetchDocuments(event, emit));
  }

  documentFetchDocuments(event, emit) async {
    emit(DocumentLoadingState());
    final failureOrFetchedDocument =
        await getDocumentsUseCase(DocumentsParams());

    emit(failureOrFetchedDocument.fold(
        (failure) => DocumentErrorState(message: mapFailureToMessage(failure)),
        (documentsEntity) =>
            DocumentsFetchedState(documentsEntity: documentsEntity)));
  }

  documentUploadCompleteEvent(event, emit) async {
    emit(DocumentLoadingState());
    final failureOrUploadDocument =
        await documentCompleteUsecase(CompleteParams());

    emit(failureOrUploadDocument.fold(
        (failure) => DocumentErrorState(message: mapFailureToMessage(failure)),
        (documentEntity) =>
            DocumentUploadedState(documentEntity: documentEntity)));
  }

  documentUploadEvent(event, emit) async {
    // driver licence
    if (event.type == "driver_licence") {
      emit(DriverLicenceLoadingState());
      final failureOrUploadDocument =
          await documentUploadUseCase(DocumentParams(
        file: event.path,
        type: event.type,
      ));

      emit(failureOrUploadDocument.fold(
          (failure) =>
              DocumentErrorState(message: mapFailureToMessage(failure)),
          (documentEntity) =>
              DriverLicenceLoadedState(documentEntity: documentEntity)));
    } else if (event.type == "insurance") {
      emit(InsuranceLoadingState());
      final failureOrUploadDocument =
          await documentUploadUseCase(DocumentParams(
        file: event.path,
        type: event.type,
      ));

      emit(failureOrUploadDocument.fold(
          (failure) =>
              DocumentErrorState(message: mapFailureToMessage(failure)),
          (documentEntity) =>
              InsuranceLoadedState(documentEntity: documentEntity)));
    } else if (event.type == "national_id") {
      emit(NationalIdLoadingState());
      final failureOrUploadDocument =
          await documentUploadUseCase(DocumentParams(
        file: event.path,
        type: event.type,
      ));

      emit(failureOrUploadDocument.fold(
          (failure) =>
              DocumentErrorState(message: mapFailureToMessage(failure)),
          (documentEntity) =>
              NationalIdLoadedState(documentEntity: documentEntity)));
    } else if (event.type == "vehicle_registration") {
      emit(VehicleRegistrationLoadingState());
      final failureOrUploadDocument =
          await documentUploadUseCase(DocumentParams(
        file: event.path,
        type: event.type,
      ));

      emit(failureOrUploadDocument.fold(
          (failure) =>
              DocumentErrorState(message: mapFailureToMessage(failure)),
          (documentEntity) =>
              VehicleRegistrationLoadedState(documentEntity: documentEntity)));
    }
  }
}
