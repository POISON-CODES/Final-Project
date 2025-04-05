import 'package:appwrite/models.dart' as models;
import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/features/files/repository/file_repository.dart';

part 'file_state.dart';

class FileCubit extends Cubit<FileState> {
  final FileRepository _repository = FileRepository();

  FileCubit() : super(FileInitial());

  Future<models.File> getFile(String fileId) async {
    try {
      emit(FileLoading());
      final file = await _repository.getFile(fileId);
      emit(FileLoaded(file));
      return file;
    } catch (e) {
      emit(FileError(e.toString()));
      rethrow;
    }
  }

  String getFileViewUrl(String fileId, String bucketId) {
    return _repository.getFileViewUrl(fileId, bucketId);
  }

  Future<String> uploadFile(String filePath, String fileName) async {
    try {
      emit(FileLoading());
      final fileId = await _repository.uploadFile(filePath, fileName);
      emit(FileUploaded(fileId));
      return fileId;
    } catch (e) {
      emit(FileError(e.toString()));
      rethrow;
    }
  }

  Future<void> deleteFile(String fileId) async {
    try {
      emit(FileLoading());
      await _repository.deleteFile(fileId);
      emit(FileDeleted());
    } catch (e) {
      emit(FileError(e.toString()));
    }
  }
}
