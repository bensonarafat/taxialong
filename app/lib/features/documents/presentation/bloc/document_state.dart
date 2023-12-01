part of 'document_bloc.dart';

@immutable
abstract class DocumentState extends Equatable {}

class DocumentLoadingState extends DocumentState {
  @override
  List<Object?> get props => [];
}

class DocumentInitialState extends DocumentState {
  @override
  List<Object?> get props => [];
}

class DocumentUploadedState extends DocumentState {
  final DocumentEntity documentEntity;

  DocumentUploadedState({required this.documentEntity});

  @override
  List<Object?> get props => [documentEntity];
}

class DocumentErrorState extends DocumentState {
  final String message;

  DocumentErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
