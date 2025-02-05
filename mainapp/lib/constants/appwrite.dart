// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwrite/appwrite.dart';

class Appwrite {
  static String projectEndPoint = 'https://10.5.107.136/v1';
  static String projectName = '67a351b601aca4ed39db';

  static final Client client = Client()
      .setEndpoint(projectEndPoint)
      .setProject(projectName)
      .setSelfSigned();

  static final Account account = Account(client);
  static final Teams teams = Teams(client);
  static final Functions functions = Functions(client);

  static final String adminTeamId = '67a3a529002dc3bb99a5';
  static final String coordinatorTeamId = '67a356480037d1ad2c27';
  static final String studentTeamId = '67a356370034c7d30d4e';

  static final String addUserToTeam = '67a352b30004ab7b74ed';
}
