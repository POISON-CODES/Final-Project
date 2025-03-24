import 'package:appwrite/appwrite.dart';
import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/models/models.dart';

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
      return FormModel.fromAppwrite(doc);
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
}
