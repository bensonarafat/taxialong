import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxialong/core/error/failure.dart';
import 'package:taxialong/features/documents/domain/entities/complete_entity.dart';
import 'package:taxialong/features/documents/domain/entities/document_entity.dart';
import 'package:taxialong/features/documents/domain/usecases/document_complete_usecase.dart';
import 'package:taxialong/features/documents/domain/usecases/document_upload_usecase.dart';

part 'document_event.dart';
part 'document_state.dart';

class DocumentBloc extends Bloc<DocumentEvent, DocumentState> {
  DocumentUploadUseCase documentUploadUseCase;
  DocumentCompleteUsecase documentCompleteUsecase;
  DocumentBloc({
    required this.documentUploadUseCase,
    required this.documentCompleteUsecase,
  }) : super(DocumentInitialState()) {
    on<DocumentEvent>((event, emit) async {
      if (event is DocumentUploadEvent) {
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
                  DocumentErrorState(message: _mapFailureToMessage(failure)),
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
                  DocumentErrorState(message: _mapFailureToMessage(failure)),
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
                  DocumentErrorState(message: _mapFailureToMessage(failure)),
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
                  DocumentErrorState(message: _mapFailureToMessage(failure)),
              (documentEntity) => VehicleRegistrationLoadedState(
                  documentEntity: documentEntity)));
        }
      } else if (event is DocumentUploadCompleteEvent) {
        emit(DocumentLoadingState());
        final failureOrUploadDocument =
            await documentCompleteUsecase(CompleteParams());

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
