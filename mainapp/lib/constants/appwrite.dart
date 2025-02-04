// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:appwrite/appwrite.dart';
import 'package:mainapp/constants/constants.dart';

class Appwrite {
  static final Client client = Client()
      .setEndpoint(Constants.projectEndPoint)
      .setProject(Constants.projectName);

  static final Account account = Account(client);
  static final Teams teams = Teams(client);
  static final Functions functions = Functions(client);

  static final String adminTeamId = '679fa32f0001fc63b65e';
  static final String coordinatorTeamId = '679fa341000fa4cb6a03';
  static final String studentTeamId = '679fa348002509b2cacf';

  static final String addUserToTeam = '67a0471f0032e4822f6c';
}
