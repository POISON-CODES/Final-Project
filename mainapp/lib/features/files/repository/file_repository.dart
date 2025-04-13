import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:mainapp/constants/constants.dart';
import 'dart:typed_data';

class FileRepository {
  final Storage _storage = Appwrite.storage;

  FileRepository();

  Future<String> uploadFile(
      Uint8List fileBytes, String fileName, String bucketId) async {
    try {
      final file = await _storage.createFile(
        bucketId: bucketId,
        fileId: ID.unique(),
        file: InputFile.fromBytes(
          bytes: fileBytes,
          filename: fileName,
          contentType: 'application/pdf', // Assuming PDF for resume
        ),
      );
      return file.$id;
    } catch (e) {
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
