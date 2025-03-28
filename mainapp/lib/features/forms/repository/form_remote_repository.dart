import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' show File;
import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/models/models.dart';
import 'dart:convert';

class FormRemoteRepository {
  Future<FormModel> createForm({
    required String title,
    required String fields,
  }) async {
    try {
      final doc = await Appwrite.databases.createDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.formsCollection,
        documentId: ID.unique(),
        data: {
          'name': title,
          'fields': fields,
          'responses': [],
        },
      );

      final formModel = FormModel.fromAppwrite(doc);
      return formModel;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<FormModel>> getAllForms() async {
    try {
      final docs = await Appwrite.databases.listDocuments(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.formsCollection,
      );

      return docs.documents.map((doc) => FormModel.fromAppwrite(doc)).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map<String, dynamic>> getForm(String formId) async {
    try {
      final doc = await Appwrite.databases.getDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.formsCollection,
        documentId: formId,
      );

      final data = Map<String, dynamic>.from(doc.data);
      if (data['fields'] is String) {
        data['fields'] = json.decode(data['fields']);
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> uploadFormFile(
    List<int> fileBytes,
    String fileName,
    String contentType,
  ) async {
    try {
      final File result = await Appwrite.storage.createFile(
        bucketId: Buckets.defaultResumeBucket,
        fileId: ID.unique(),
        file: InputFile.fromBytes(
          bytes: fileBytes,
          filename: fileName,
          contentType: contentType,
        ),
      );

      return result.$id;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> submitFormResponse(FormResponseModel response) async {
    try {
      await Appwrite.databases.createDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.formsCollection,
        documentId: response.id,
        data: response.toMap(),
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
