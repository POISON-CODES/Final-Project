import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:mainapp/constants/appwrite.dart';
import 'package:mainapp/models/user_model.dart';

class AuthRemoteRepository {
  Future<UserModel?> createUser({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      final user = await Appwrite.account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );

      await Appwrite.functions.createExecution(
          functionId: '67a0471f0032e4822f6c',
          body: json.encode({
            "userId": user.$id,
            "teamId": Appwrite.studentTeamId,
          }));

      return UserModel.fromAppwrite(user);
    } catch (e) {
      throw e.toString();
    }
  }
}
