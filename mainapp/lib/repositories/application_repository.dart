import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/models/application_model.dart';

class ApplicationRepository {
  ApplicationRepository();

  Future<List<ApplicationModel>> getApplications() async {
    try {
      DocumentList documents = await Appwrite.databases.listDocuments(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.applicationsCollection,
      );

      return documents.documents.map((doc) {
        return ApplicationModel(
          id: doc.$id,
          userId: doc.data['userId'],
          companyId: doc.data['companyId'],
          createdAt: DateTime.parse(doc.$createdAt),
          updatedAt: DateTime.parse(doc.$updatedAt),
          data: doc.data['data'] ?? {},
          position: doc.data['position'],
        );
      }).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ApplicationModel>> getApplicationsByUserId(String userId) async {
    try {
      final databases = Appwrite.databases;
      final result = await databases.listDocuments(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.applicationsCollection,
        queries: [
          Query.equal('userId', userId),
        ],
      );

      return result.documents
          .map((doc) => ApplicationModel.fromMap(doc.data))
          .toList();
    } catch (e) {
      throw Exception('Failed to get applications: $e');
    }
  }

  Future<List<ApplicationModel>> getApplicationsByCompanyId(
      String companyId) async {
    try {
      DocumentList documents = await Appwrite.databases.listDocuments(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.applicationsCollection,
        queries: [
          Query.equal('companyId', companyId),
        ],
      );

      return documents.documents.map((doc) {
        return ApplicationModel(
          id: doc.$id,
          userId: doc.data['userId'],
          companyId: doc.data['companyId'],
          createdAt: DateTime.parse(doc.$createdAt),
          updatedAt: DateTime.parse(doc.$updatedAt),
          data: doc.data['data'] ?? {},
          position: doc.data['position'],
        );
      }).toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ApplicationModel> createApplication({
    required String userId,
    required String companyId,
    required String position,
    required Map<String, dynamic> masterData,
  }) async {
    try {
      final application = ApplicationModel(
        id: '',
        userId: userId,
        companyId: companyId,
        position: position,
        status: ApplicationStatus.pending,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        data: masterData,
      );

      final result = await Appwrite.databases.createDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.applicationsCollection,
        documentId: ID.unique(),
        data: application.toMap(),
      );

      return ApplicationModel.fromMap(result.data);
    } catch (e) {
      throw Exception('Failed to create application: $e');
    }
  }

  Future<void> deleteApplication(String id) async {
    try {
      await Appwrite.databases.deleteDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.applicationsCollection,
        documentId: id,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> hasUserApplied(String userId, String companyId) async {
    try {
      final result = await Appwrite.databases.listDocuments(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.applicationsCollection,
        queries: [
          Query.equal('userId', userId),
          Query.equal('companyId', companyId),
        ],
      );

      return result.documents.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check application status: $e');
    }
  }

  Future<ApplicationModel> updateApplicationStatus(
    String applicationId,
    ApplicationStatus status,
  ) async {
    try {
      final result = await Appwrite.databases.updateDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.applicationsCollection,
        documentId: applicationId,
        data: {
          'status': status.toString().split('.').last,
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );

      return ApplicationModel.fromMap(result.data);
    } catch (e) {
      throw Exception('Failed to update application status: $e');
    }
  }
}
