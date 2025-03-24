import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/models/models.dart';

class ConfigurationRepository {
  Future<ConfigurationModel?> createConfiguration({
    required String department,
    required String course,
    required String specialization,
    required String courseCode,
    required String hoi,
    required String facultyCoordinator,
    required String graduateStatus,
  }) async {
    try {
      Document doc = await Appwrite.databases.createDocument(
          databaseId: DatabaseIds.crcDatabase,
          collectionId: CollectionsIds.batchConfigsCollection,
          documentId: ID.unique(),
          data: {
            'department': department,
            'course': course,
            'courseCode': courseCode,
            'hoi': hoi,
            'facultyCoordinator': facultyCoordinator,
            'graduateStatus': graduateStatus,
            'specialization': specialization,
            'studentList': [], // Initialize with empty student list
          });
      ConfigurationModel model = ConfigurationModel.fromAppwrite(doc);
      return model;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<ConfigurationModel>> getAllConfigurations() async {
    try {
      DocumentList documents = await Appwrite.databases.listDocuments(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.batchConfigsCollection,
      );

      List<ConfigurationModel> configurations = documents.documents.map((doc) {
        return ConfigurationModel.fromAppwrite(doc);
      }).toList();

      return configurations;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<ConfigurationModel> updateConfiguration({
    required String id,
    required String department,
    required String course,
    required String specialization,
    required String courseCode,
    required String hoi,
    required String facultyCoordinator,
    required String graduateStatus,
  }) async {
    try {
      Document doc = await Appwrite.databases.updateDocument(
          databaseId: DatabaseIds.crcDatabase,
          collectionId: CollectionsIds.batchConfigsCollection,
          documentId: id,
          data: {
            'department': department,
            'course': course,
            'courseCode': courseCode,
            'hoi': hoi,
            'facultyCoordinator': facultyCoordinator,
            'graduateStatus': graduateStatus,
            'specialization': specialization,
          });

      ConfigurationModel model = ConfigurationModel.fromAppwrite(doc);
      return model;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> deleteConfiguration(String id) async {
    try {
      await Appwrite.databases.deleteDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.batchConfigsCollection,
        documentId: id,
      );
      return true;
    } catch (e) {
      throw e.toString();
    }
  }
}
