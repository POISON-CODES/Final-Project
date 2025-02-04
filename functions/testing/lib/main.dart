import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dart_appwrite/dart_appwrite.dart';

Future<dynamic> main(final context) async {
  final client = Client()
      .setEndpoint(Platform.environment['APPWRITE_FUNCTION_API_ENDPOINT'] ?? '')
      .setProject(Platform.environment['APPWRITE_FUNCTION_PROJECT_ID'] ?? '')
      .setKey(context.req.headers['x-appwrite-key'] ?? '');
  final teams = Teams(client);

  final body = jsonDecode(context.req.body);

  final user = body['userId'];
  final team = body['teamId'];

  await teams.createMembership(
    teamId: team,
    userId: user,
    roles: ['member'],
    url: Platform.environment['APPWRITE_FUNCTION_API_ENDPOINT'] ?? '',
  );

  return context.res
      .json({"Success": true, "userId": user, "membership": "student"});
}
