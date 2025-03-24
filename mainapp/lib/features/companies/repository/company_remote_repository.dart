import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/models/models.dart';

class CompanyRepository {
  Future<CompanyModel?> createCompany({
    required String name,
    required List<String> positions,
    required List<String> ctc,
    String? location,
    required String provider,
    required List<String> eligibleBatchesIds,
    required String formId,
    List<String> jdFiles = const [],
  }) async {
    try {
      Document doc = await Appwrite.databases.createDocument(
          databaseId: DatabaseIds.crcDatabase,
          collectionId: CollectionsIds.companiesCollection,
          documentId: ID.unique(),
          data: {
            'name': name,
            'positions': positions,
            'ctc': ctc,
            'location': location,
            'provider': provider,
            'eligibleBatchesIds': eligibleBatchesIds,
            'formId': formId,
            'jdFiles': jdFiles,
          });

      CompanyModel model = CompanyModel(
        id: doc.$id,
        name: doc.data['name'],
        positions: List<String>.from(doc.data['positions']),
        ctc: List<String>.from(doc.data['ctc']),
        location: doc.data['location'],
        provider: doc.data['provider'],
        eligibleBatchesIds: List<String>.from(doc.data['eligibleBatchesIds']),
        formId: doc.data['formId'],
        jdFiles: doc.data['jdFiles'] != null
            ? List<String>.from(doc.data['jdFiles'])
            : const [],
      );

      return model;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<CompanyModel>> getAllCompanies() async {
    try {
      DocumentList documents = await Appwrite.databases.listDocuments(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.companiesCollection,
      );

      List<CompanyModel> companies = documents.documents.map((doc) {
        return CompanyModel(
          id: doc.$id,
          name: doc.data['name'],
          positions: List<String>.from(doc.data['positions']),
          ctc: List<String>.from(doc.data['ctc']),
          location: doc.data['location'],
          provider: doc.data['provider'],
          eligibleBatchesIds: List<String>.from(doc.data['eligibleBatchesIds']),
          formId: doc.data['formId'],
          jdFiles: doc.data['jdFiles'] != null
              ? List<String>.from(doc.data['jdFiles'])
              : const [],
        );
      }).toList();

      return companies;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<CompanyModel> updateCompany({
    required String id,
    required String name,
    required List<String> positions,
    required List<String> ctc,
    String? location,
    required String provider,
    required List<String> eligibleBatchesIds,
    required String formId,
    List<String>? jdFiles,
  }) async {
    try {
      Map<String, dynamic> data = {
        'name': name,
        'positions': positions,
        'ctc': ctc,
        'location': location,
        'provider': provider,
        'eligibleBatchesIds': eligibleBatchesIds,
        'formId': formId,
      };

      if (jdFiles != null) {
        data['jdFiles'] = jdFiles;
      }

      Document doc = await Appwrite.databases.updateDocument(
          databaseId: DatabaseIds.crcDatabase,
          collectionId: CollectionsIds.companiesCollection,
          documentId: id,
          data: data);

      CompanyModel model = CompanyModel(
        id: doc.$id,
        name: doc.data['name'],
        positions: List<String>.from(doc.data['positions']),
        ctc: List<String>.from(doc.data['ctc']),
        location: doc.data['location'],
        provider: doc.data['provider'],
        eligibleBatchesIds: List<String>.from(doc.data['eligibleBatchesIds']),
        formId: doc.data['formId'],
        jdFiles: doc.data['jdFiles'] != null
            ? List<String>.from(doc.data['jdFiles'])
            : const [],
      );

      return model;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> deleteCompany(String id) async {
    try {
      await Appwrite.databases.deleteDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.companiesCollection,
        documentId: id,
      );
      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  // Method to upload a JD file to storage
  Future<String> uploadJDFile(
    List<int> fileBytes,
    String fileName,
    String contentType,
  ) async {
    try {
      final File result = await Appwrite.storage.createFile(
        bucketId: Buckets.jdFilesBucket,
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
}
