import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/models/models.dart';

class AuthRemoteRepository {
  Future<UserModel?> getCurrentUser() async {
    User? user;

    try {
      user = await Appwrite.account.get();
    } catch (e) {
      user = null;
      return null;
    }

    final teamIds = [
      TeamIds.adminTeamId,
      TeamIds.coordinatorTeamId,
      TeamIds.studentTeamId
    ];

    MembershipList? userTeamList;
    String userTeamId = TeamIds.studentTeamId;

    for (var teamId in teamIds) {
      try {
        userTeamList = await Appwrite.teams.listMemberships(teamId: teamId);
        final isMember =
            userTeamList.memberships.any((m) => m.userId == user!.$id);

        if (isMember) {
          userTeamId = teamId;
          break;
        }
      } catch (e) {
        continue;
      }
    }

    final userModel = UserModel.fromAppwrite(user);
    userModel.position = userTeamId == TeamIds.adminTeamId
        ? Position.admin
        : userTeamId == TeamIds.coordinatorTeamId
            ? Position.coordinator
            : Position.student;

    return userModel;
  }

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
        TeamIds.adminTeamId,
        TeamIds.coordinatorTeamId,
        TeamIds.studentTeamId
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
      userModel.position = userTeamId == TeamIds.adminTeamId
          ? Position.admin
          : userTeamId == TeamIds.coordinatorTeamId
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
      User user = await Appwrite.account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );

      await Appwrite.functions.createExecution(
          functionId: FunctionIds.addUserToTeam,
          body: json.encode({
            "userId": user.$id,
            "teamId": TeamIds.studentTeamId,
          }));

      final userModel =
          UserModel.fromAppwrite(user).copyWith(phoneNumber: phoneNumber);

      await Appwrite.databases.createDocument(
          databaseId: DatabaseIds.crcDatabase,
          collectionId: CollectionsIds.usersCollection,
          documentId: user.$id,
          data: userModel.toMap());

      return userModel;
    } catch (e) {
      throw e.toString();
    }
  }
}
