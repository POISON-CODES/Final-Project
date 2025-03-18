import 'dart:convert';

import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/models/models.dart';

class FormRemoteRepository {
  Future<FormModel> createForm({
    required String formId,
    required String title,
    required Map<String, dynamic> fields,
  }) async {
    try {
      final response = await Appwrite.functions.createExecution(
          functionId: FunctionIds.createForm,
          body: json.encode({
            "formsDatabase": DatabaseIds.formsDatabase,
            "formId": formId,
            "formName": title,
          }));
    } catch (e) {
      throw e.toString();
    }
  }
}
