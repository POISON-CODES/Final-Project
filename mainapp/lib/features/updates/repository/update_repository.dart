import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' show Document, DocumentList;
import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/models/models.dart';

class UpdateRepository {
  Future<UpdateModel?> createUpdate({
    required String companyId,
    required String update,
    required Priority priority,
  }) async {
    try {
      Document doc = await Appwrite.databases.createDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.updatesCollection,
        documentId: ID.unique(),
        data: {
          'companyId': companyId,
          'update': update,
          'priority': priority.name,
          'createdAt': DateTime.now().toIso8601String(),
        },
      );

      return UpdateModel.fromMap({
        'id': doc.$id,
        ...doc.data,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<UpdateModel>> getAllUpdates() async {
    try {
      DocumentList documents = await Appwrite.databases.listDocuments(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.updatesCollection,
        queries: [
          Query.orderDesc('createdAt'),
        ],
      );

      return documents.documents
          .map((doc) => UpdateModel.fromMap({
                'id': doc.$id,
                ...doc.data,
              }))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<UpdateModel>> getUpdatesByCompany(String companyId) async {
    try {
      DocumentList documents = await Appwrite.databases.listDocuments(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.updatesCollection,
        queries: [
          Query.equal('companyId', companyId),
          Query.orderDesc('createdAt'),
        ],
      );

      return documents.documents
          .map((doc) => UpdateModel.fromMap({
                'id': doc.$id,
                ...doc.data,
              }))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> deleteUpdate(String id) async {
    try {
      await Appwrite.databases.deleteDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.updatesCollection,
        documentId: id,
      );
      return true;
    } catch (e) {
      throw e.toString();
    }
  }
}
