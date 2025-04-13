import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/models/models.dart';

class RequestRepository {
  Future<List<RequestModel>> getRequests() async {
    try {
      DocumentList documents = await Appwrite.databases.listDocuments(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.requestsCollection,
      );

      List<RequestModel> requests = [];
      for (var doc in documents.documents) {
        final request = RequestModel.fromJson({
          'id': doc.$id,
          ...doc.data,
        });

        // Get approver name if exists
        if (request.approvedBy != null) {
          try {
            final approver = await Appwrite.databases.getDocument(
              databaseId: DatabaseIds.crcDatabase,
              collectionId: CollectionsIds.usersCollection,
              documentId: request.approvedBy!,
            );
            request.approvedBy = approver.data['name'] as String;
          } catch (e) {
            // If user not found, keep the ID
          }
        }

        // Get rejecter name if exists
        if (request.rejectedBy != null) {
          try {
            final rejecter = await Appwrite.databases.getDocument(
              databaseId: DatabaseIds.crcDatabase,
              collectionId: CollectionsIds.usersCollection,
              documentId: request.rejectedBy!,
            );
            request.rejectedBy = rejecter.data['name'] as String;
          } catch (e) {
            // If user not found, keep the ID
          }
        }

        requests.add(request);
      }

      return requests;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<RequestModel> getRequestById(String id) async {
    try {
      Document doc = await Appwrite.databases.getDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.requestsCollection,
        documentId: id,
      );

      return RequestModel.fromJson({
        'id': doc.$id,
        ...doc.data,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<RequestModel>> getRequestsByUserId(String userId) async {
    try {
      DocumentList documents = await Appwrite.databases.listDocuments(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.requestsCollection,
        queries: [
          Query.equal('userId', userId),
          Query.orderDesc('createdAt'),
        ],
      );

      return documents.documents
          .map((doc) => RequestModel.fromJson({
                'id': doc.$id,
                ...doc.data,
              }))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<RequestModel>> getRequestsByType(String type) async {
    try {
      DocumentList documents = await Appwrite.databases.listDocuments(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.requestsCollection,
        queries: [
          Query.equal('type', type),
          Query.orderDesc('createdAt'),
        ],
      );

      return documents.documents
          .map((doc) => RequestModel.fromJson({
                'id': doc.$id,
                ...doc.data,
              }))
          .toList();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<RequestModel> createRequest(RequestModel request, String id) async {
    try {
      Document doc = await Appwrite.databases.createDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.requestsCollection,
        documentId: id,
        data: request.toJson(),
      );

      return RequestModel.fromJson({
        'id': doc.$id,
        ...doc.data,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<RequestModel> updateRequest(
      String id, Map<String, dynamic> data) async {
    try {
      Document doc = await Appwrite.databases.updateDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.requestsCollection,
        documentId: id,
        data: data,
      );

      return RequestModel.fromJson({
        'id': doc.$id,
        ...doc.data,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteRequest(String id) async {
    try {
      await Appwrite.databases.deleteDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.requestsCollection,
        documentId: id,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<RequestModel> approveRequest(String id, String approvedBy) async {
    try {
      Document doc = await Appwrite.databases.updateDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.requestsCollection,
        documentId: id,
        data: {
          'status': 'approved',
          'approvedBy': approvedBy,
        },
      );

      return RequestModel.fromJson({
        'id': doc.$id,
        ...doc.data,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<RequestModel> rejectRequest(
      String id, String rejectedBy, String reason) async {
    try {
      Document doc = await Appwrite.databases.updateDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.requestsCollection,
        documentId: id,
        data: {
          'status': 'rejected',
          'rejectedBy': rejectedBy,
          'rejectionReason': reason,
        },
      );

      return RequestModel.fromJson({
        'id': doc.$id,
        ...doc.data,
      });
    } catch (e) {
      throw e.toString();
    }
  }
}
