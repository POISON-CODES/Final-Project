import 'package:appwrite/appwrite.dart';
import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/models/models.dart';

class MasterDataRepository {
  MasterDataRepository();

  Future<void> submitMasterData(MasterDataModel masterData) async {
    try {
      await Appwrite.databases.createDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.masterCollection,
        documentId: ID.unique(),
        data: masterData.toMap(),
      );
    } catch (e) {
      throw Exception('Failed to submit master data: $e');
    }
  }
}
