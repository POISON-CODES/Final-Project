import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dart_appwrite/dart_appwrite.dart';

Future<dynamic> main(final context) async {
  final endPoint = 'http://10.5.110.241/v1';

  final client = Client()
      // .setEndpoint(Platform.environment['APPWRITE_FUNCTION_API_ENDPOINT'] ?? '')

      .setEndpoint(endPoint)
      .setProject(Platform.environment['APPWRITE_FUNCTION_PROJECT_ID'] ?? '')
      .setKey(
          'standard_8e8e8d7b14f072aca65a850a5ca3cc55b1f1f450124e0ff497a621d264a00c2897cec6029c6c46a86ef9ee64a22b1a0be867e2ecafa53be477d8f31a3c1d3c9d7e2bafd29a264b257eac888440c7c1e854df36beffdb303a499da5d700ce6f9cc828bcf02a9b939a396c8710cbf5d662e8a642f225f9fa5b46f36821a8dd71df')
      .setSelfSigned();

  final teams = Teams(client);

  try {
    final body = jsonDecode(context.req.body);

    // Validate required parameters
    if (!body.containsKey('userId') ||
        !body.containsKey('teamId') ||
        !body.containsKey('email')) {
      return context.res.json({
        "Success": false,
        "message": "Missing required parameters (userId, teamId, email)"
      }, status: 400);
    }

    final userId = body['userId'];
    final teamId = body['teamId'];
    final email = body['email']; // Required by Appwrite API

    final membership = await teams.createMembership(
      teamId: teamId,
      email: email, // This is required for inviting a user
      userId: userId, // Optional, use only if the user is registered
      roles: ['member'],
      url: endPoint,
    );

    return context.res.json({
      "Success": true,
      "userId": userId,
      "membership": membership.toMap(),
    });
  } catch (e, stackTrace) {
    context.log("Error: $e\nStackTrace: $stackTrace");
    return context.res.json(
        {"Success": false, "message": "Internal Server Error"},
        status: 500);
  }
}
