part of 'document_bloc.dart';

@immutable
abstract class DocumentEvent extends Equatable {}

class DocumentFetchDocuments extends DocumentEvent {
  @override
  List<Object?> get props => [];
}

class DocumentUploadEvent extends DocumentEvent {
  final String type;
  final String path;

  DocumentUploadEvent({required this.type, required this.path});
  @override
  List<Object?> get props => [type, path];
}

class DocumentUploadCompleteEvent extends DocumentEvent {
  @override
  List<Object?> get props => [];
}
