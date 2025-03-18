part of 'constants.dart';

class Appwrite {
  // static String projectEndPoint = 'https://10.5.127.42/v1';
  static String projectEndPoint = 'https://10.5.110.241/v1';
  static String projectName = '67a351b601aca4ed39db';

  static final Client client = Client()
      .setEndpoint(projectEndPoint)
      .setProject(projectName)
      .setSelfSigned();

  static final Account account = Account(client);
  static final Teams teams = Teams(client);
  static final Functions functions = Functions(client);
  static final Databases databases = Databases(client);
}

class DatabaseIds {
  static final String crcDatabase = '67a5a03a000bf36ee5a9';
  static final String formsDatabase = '67d9185800377484f0f4';
}

class TeamIds {
  static final String adminTeamId = '67a3a529002dc3bb99a5';
  static final String coordinatorTeamId = '67a356480037d1ad2c27';
  static final String studentTeamId = '67a356370034c7d30d4e';
}

class CollectionsIds {
  static final String batchConfigsCollection = '67a6ffd3001301054ce0';
  static final String usersCollection = '67a6fef2003d7ef6d69f';
  static final String companiesCollection = '67a5a04200109abb5416';
}

class FunctionIds {
  static final String addUserToTeam = '67a352b30004ab7b74ed';
  static final String createForm = '67a8b2be002191ea0564';
}

class Buckets {
  static final String defaultResumeBucket = '67a86ff6000fcf767ea0';
}
