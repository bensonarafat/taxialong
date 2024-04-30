part of 'document_bloc.dart';

@immutable
abstract class DocumentState extends Equatable {}

class DocumentLoadingState extends DocumentState {
  @override
  List<Object?> get props => [];
}

class DriverLicenceLoadingState extends DocumentState {
  @override
  List<Object?> get props => [];
}

class DriverLicenceLoadedState extends DocumentState {
  final DocumentEntity documentEntity;

  DriverLicenceLoadedState({required this.documentEntity});
  @override
  List<Object?> get props => [documentEntity];
}

class NationalIdLoadingState extends DocumentState {
  @override
  List<Object?> get props => [];
}

class NationalIdLoadedState extends DocumentState {
  final DocumentEntity documentEntity;

  NationalIdLoadedState({required this.documentEntity});
  @override
  List<Object?> get props => [documentEntity];
}

class UnionIDLoadingState extends DocumentState {
  @override
  List<Object?> get props => [];
}

class UnionIDLoadedState extends DocumentState {
  final DocumentEntity documentEntity;

  UnionIDLoadedState({required this.documentEntity});
  @override
  List<Object?> get props => [documentEntity];
}

class DocumentInitialState extends DocumentState {
  @override
  List<Object?> get props => [];
}

class DocumentUploadedState extends DocumentState {
  final CompleteEntity documentEntity;

  DocumentUploadedState({required this.documentEntity});

  @override
  List<Object?> get props => [documentEntity];
}

class DocumentsFetchedState extends DocumentState {
  final List<DocumentsEntity> documentsEntity;

  DocumentsFetchedState({required this.documentsEntity});

  @override
  List<Object?> get props => [documentsEntity];
}

class DocumentErrorState extends DocumentState {
  final String message;

  DocumentErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
