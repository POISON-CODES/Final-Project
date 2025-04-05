part of 'file_cubit.dart';

abstract class FileState extends Equatable {
  const FileState();

  @override
  List<Object> get props => [];
}

class FileInitial extends FileState {}

class FileLoading extends FileState {}

class FileLoaded extends FileState {
  final models.File file;

  const FileLoaded(this.file);

  @override
  List<Object> get props => [file];
}

class FileUploaded extends FileState {
  final String fileId;

  const FileUploaded(this.fileId);

  @override
  List<Object> get props => [fileId];
}

class FileDeleted extends FileState {}

class FileError extends FileState {
  final String message;

  const FileError(this.message);

  @override
  List<Object> get props => [message];
}
