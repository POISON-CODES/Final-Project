import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:mainapp/constants/appwrite.dart';
import 'package:mainapp/constants/enums.dart';
import 'package:mainapp/models/user_model.dart';

class AuthRemoteRepository {
  Future<UserModel> logInUser({
    required String email,
    required String password,
  }) async {
    try {
      await Appwrite.account.createEmailPasswordSession(
        email: email,
        password: password,
      );

      final user = await Appwrite.account.get();

      final teamIds = [
        Appwrite.adminTeamId,
        Appwrite.coordinatorTeamId,
        Appwrite.studentTeamId
      ];

      MembershipList? userTeamList;
      String userTeamId = '';

      for (var teamId in teamIds) {
        try {
          userTeamList = await Appwrite.teams.listMemberships(teamId: teamId);
          final isMember =
              userTeamList.memberships.any((m) => m.userId == user.$id);

          if (isMember) {
            userTeamId = teamId;
            break;
          }
        } catch (e) {
          continue;
        }
      }

      final userModel = UserModel.fromAppwrite(user);
      userModel.position = userTeamId == Appwrite.adminTeamId
          ? Position.admin
          : userTeamId == Appwrite.coordinatorTeamId
              ? Position.coordinator
              : Position.student;

      return userModel;
    } on AppwriteException catch (e) {
      throw Exception('Login failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<UserModel?> createUser({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
  }) async {
    try {
      final User user = await Appwrite.account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );

      await Appwrite.functions.createExecution(
          functionId: Appwrite.addUserToTeam,
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
