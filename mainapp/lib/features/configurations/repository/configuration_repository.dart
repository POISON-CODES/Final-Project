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
          });
      ConfigurationModel model = ConfigurationModel.fromAppwrite(doc);
      return model;
    } catch (e) {
      throw e.toString();
    }
  }
}
