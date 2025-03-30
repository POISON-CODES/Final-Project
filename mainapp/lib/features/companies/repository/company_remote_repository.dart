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
    String? description,
    required String floatBy,
    required List<String> eligibleBatchesIds,
    required String formId,
    List<String> jdFiles = const [],
    DateTime? deadline,
    DateTime? floatTime,
    List<String>? updates,
    List<String>? students,
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
            'description': description,
            'floatBy': floatBy,
            'eligibleBatchesIds': eligibleBatchesIds,
            'formId': formId,
            'jdFiles': jdFiles,
            'deadline': deadline?.toIso8601String(),
            'floatTime': floatTime?.toIso8601String() ??
                DateTime.now().toIso8601String(),
            'updates': updates,
            'students': students,
          });

      CompanyModel model = CompanyModel(
        id: doc.$id,
        name: doc.data['name'],
        positions: List<String>.from(doc.data['positions']),
        ctc: List<String>.from(doc.data['ctc']),
        location: doc.data['location'],
        description: doc.data['description'],
        floatBy: doc.data['floatBy'],
        eligibleBatchesIds: List<String>.from(doc.data['eligibleBatchesIds']),
        formId: doc.data['formId'],
        jdFiles: doc.data['jdFiles'] != null
            ? List<String>.from(doc.data['jdFiles'])
            : const [],
        deadline: doc.data['deadline'] != null
            ? DateTime.parse(doc.data['deadline'] as String)
            : null,
        floatTime: doc.data['floatTime'] != null
            ? DateTime.parse(doc.data['floatTime'] as String)
            : DateTime.now(),
        updates: doc.data['updates'] != null
            ? List<String>.from(doc.data['updates'])
            : null,
        students: doc.data['students'] != null
            ? List<String>.from(doc.data['students'])
            : null,
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
          description: doc.data['description'],
          floatBy: doc.data['floatBy'],
          eligibleBatchesIds: List<String>.from(doc.data['eligibleBatchesIds']),
          formId: doc.data['formId'],
          jdFiles: doc.data['jdFiles'] != null
              ? List<String>.from(doc.data['jdFiles'])
              : const [],
          deadline: doc.data['deadline'] != null
              ? DateTime.parse(doc.data['deadline'] as String)
              : null,
          floatTime: doc.data['floatTime'] != null
              ? DateTime.parse(doc.data['floatTime'] as String)
              : DateTime.now(),
          updates: doc.data['updates'] != null
              ? List<String>.from(doc.data['updates'])
              : null,
          students: doc.data['students'] != null
              ? List<String>.from(doc.data['students'])
              : null,
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
    String? description,
    required String floatBy,
    required List<String> eligibleBatchesIds,
    required String formId,
    List<String>? jdFiles,
    DateTime? deadline,
    DateTime? floatTime,
    List<String>? updates,
    List<String>? students,
  }) async {
    try {
      Map<String, dynamic> data = {
        'name': name,
        'positions': positions,
        'ctc': ctc,
        'location': location,
        'description': description,
        'floatBy': floatBy,
        'eligibleBatchesIds': eligibleBatchesIds,
        'formId': formId,
      };

      if (jdFiles != null) {
        data['jdFiles'] = jdFiles;
      }

      if (deadline != null) {
        data['deadline'] = deadline.toIso8601String();
      }

      if (floatTime != null) {
        data['floatTime'] = floatTime.toIso8601String();
      }

      if (updates != null) {
        data['updates'] = updates;
      }

      if (students != null) {
        data['students'] = students;
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
        description: doc.data['description'],
        floatBy: doc.data['floatBy'],
        eligibleBatchesIds: List<String>.from(doc.data['eligibleBatchesIds']),
        formId: doc.data['formId'],
        jdFiles: doc.data['jdFiles'] != null
            ? List<String>.from(doc.data['jdFiles'])
            : const [],
        deadline: doc.data['deadline'] != null
            ? DateTime.parse(doc.data['deadline'] as String)
            : null,
        floatTime: doc.data['floatTime'] != null
            ? DateTime.parse(doc.data['floatTime'] as String)
            : DateTime.now(),
        updates: doc.data['updates'] != null
            ? List<String>.from(doc.data['updates'])
            : null,
        students: doc.data['students'] != null
            ? List<String>.from(doc.data['students'])
            : null,
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
      print("result: $result");

      return result.$id;
    } catch (e) {
      print("error: $e");
      throw e.toString();
    }
  }
}
