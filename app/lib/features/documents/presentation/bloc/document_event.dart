part of 'document_bloc.dart';

@immutable
abstract class DocumentEvent extends Equatable {}

class DocumentUploadEvent extends DocumentEvent {
  final String type;
  final String path;

  DocumentUploadEvent({required this.type, required this.path});
  @override
  List<Object?> get props => [type, path];
}
