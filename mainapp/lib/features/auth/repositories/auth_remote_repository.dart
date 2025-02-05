import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:mainapp/constants/appwrite.dart';
import 'package:mainapp/core/utils/types.dart';
import 'package:mainapp/models/user_model.dart';

class AuthRemoteRepository {
  Future<Result<UserModel>> logInUser({
    required String email,
    required String password,
  }) async {
    try {
      await Appwrite.account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      print(Appwrite.adminTeamId);
      MembershipList adminTeamList =
          await Appwrite.teams.listMemberships(teamId: Appwrite.adminTeamId);
      print(2);
      MembershipList coordTeamList = await Appwrite.teams
          .listMemberships(teamId: Appwrite.coordinatorTeamId);

      final String userTeamId =
          adminTeamList.memberships.any((m) => m.teamId == Appwrite.adminTeamId)
              ? Appwrite.adminTeamId
              : coordTeamList.memberships
                      .any((m) => m.teamId == Appwrite.coordinatorTeamId)
                  ? Appwrite.coordinatorTeamId
                  : Appwrite.studentTeamId;

      return Result(
        userModel: UserModel.fromAppwrite(
          await Appwrite.account.get(),
        ),
        teamId: userTeamId,
      );
    } catch (e) {
      throw e.toString();
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

      final membership = await Appwrite.functions.createExecution(
          functionId: Appwrite.addUserToTeam,
          body: json.encode({
            "userId": user.$id,
            "teamId": Appwrite.studentTeamId,
          }));

      print(membership.functionId);

      return UserModel.fromAppwrite(user);
    } catch (e) {
      throw e.toString();
    }
  }
}
