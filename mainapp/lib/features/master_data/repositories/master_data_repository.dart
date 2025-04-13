import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/models/models.dart';

class MasterDataRepository {
  MasterDataRepository();

  Future<String> submitMasterData(MasterDataModel masterData, String id) async {
    try {
      final doc = await Appwrite.databases.createDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.masterCollection,
        documentId: id,
        data: masterData.toMap(),
      );
      return doc.$id;
    } catch (e) {
      throw Exception('Failed to submit master data: $e');
    }
  }

  Future<List<MasterDataModel>> getAllMasterData() async {
    try {
      final docs = await Appwrite.databases.listDocuments(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.masterCollection,
      );

      return docs.documents.map((doc) {
        final data = Map<String, dynamic>.from(doc.data);
        if (data['dob'] is String) {
          data['dob'] = DateTime.parse(data['dob']).millisecondsSinceEpoch;
        }
        return MasterDataModel.fromMap({
          'id': doc.$id,
          ...data,
        });
      }).toList();
    } catch (e) {
      throw Exception('Failed to get master data: $e');
    }
  }

  Future<MasterDataModel> getMasterDataById(String id) async {
    try {
      final doc = await Appwrite.databases.getDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.masterCollection,
        documentId: id,
      );

      // Convert the dob field to milliseconds if it's a string
      final data = Map<String, dynamic>.from(doc.data);
      if (data['dob'] is String) {
        data['dob'] = DateTime.parse(data['dob']).millisecondsSinceEpoch;
      }

      return MasterDataModel.fromMap({
        'id': doc.$id,
        ...data,
      });
    } catch (e) {
      throw Exception('Failed to get master data: $e');
    }
  }

  Future<MasterDataModel> approveMasterData(String id) async {
    try {
      final doc = await Appwrite.databases.updateDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.masterCollection,
        documentId: id,
        data: {
          'approved': true,
        },
      );

      // Convert the dob field to milliseconds if it's a string
      final data = Map<String, dynamic>.from(doc.data);
      if (data['dob'] is String) {
        data['dob'] = DateTime.parse(data['dob']).millisecondsSinceEpoch;
      }

      return MasterDataModel.fromMap({
        'id': doc.$id,
        ...data,
      });
    } catch (e) {
      throw Exception('Failed to approve master data: $e');
    }
  }

  Future<MasterDataModel> rejectMasterData(String id) async {
    try {
      final doc = await Appwrite.databases.updateDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.masterCollection,
        documentId: id,
        data: {
          'approved': false,
        },
      );

      // Convert the dob field to milliseconds if it's a string
      final data = Map<String, dynamic>.from(doc.data);
      if (data['dob'] is String) {
        data['dob'] = DateTime.parse(data['dob']).millisecondsSinceEpoch;
      }

      return MasterDataModel.fromMap({
        'id': doc.$id,
        ...data,
      });
    } catch (e) {
      throw Exception('Failed to reject master data: $e');
    }
  }

  // Future<String> uploadResume(
  //     List<int> fileBytes, String fileName, String contentType) async {
  //   try {
  //     final file = await Appwrite.storage.createFile(
  //       bucketId: Buckets.defaultResumeBucket,
  //       fileId: ID.unique(),
  //       file: InputFile.fromBytes(
  //         bytes: fileBytes,
  //         filename: fileName,
  //         contentType: contentType,
  //       ),
  //     );
  //     return file.$id;
  //   } catch (e) {
  //     throw Exception('Failed to upload resume: $e');
  //   }
  // }
}
