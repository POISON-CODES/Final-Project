import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:mainapp/constants/constants.dart';
import 'package:flutter/foundation.dart';

class FileRepository {
  final Storage _storage = Appwrite.storage;

  FileRepository();

  Future<String> uploadFile(String filePath, String fileName) async {
    try {
      final file = await _storage.createFile(
        bucketId: Buckets.jdFilesBucket,
        fileId: ID.unique(),
        file: InputFile.fromPath(
          path: filePath,
          filename: fileName,
        ),
      );
      return file.$id;
    } catch (e) {
      debugPrint('Error uploading file: $e');
      rethrow;
    }
  }

  Future<models.File> getFile(String fileId) async {
    try {
      return await _storage.getFile(
        bucketId: Buckets.jdFilesBucket,
        fileId: fileId,
      );
    } catch (e) {
      debugPrint('Error getting file: $e');
      rethrow;
    }
  }

  Future<void> deleteFile(String fileId) async {
    try {
      await _storage.deleteFile(
        bucketId: Buckets.jdFilesBucket,
        fileId: fileId,
      );
    } catch (e) {
      debugPrint('Error deleting file: $e');
      rethrow;
    }
  }

  String getFileViewUrl(String fileId, String bucketId) {
    return '${Appwrite.projectEndPoint}/storage/buckets/$bucketId/files/$fileId/view?project=${Appwrite.projectName}';
  }

  String getFileDownloadUrl(String fileId) {
    return _storage
        .getFileDownload(
          bucketId: Buckets.jdFilesBucket,
          fileId: fileId,
        )
        .toString();
  }
}
