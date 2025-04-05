part of 'constants.dart';

class Appwrite {
  // static String projectEndPoint = 'https://10.5.127.42/v1';
  static String projectEndPoint = 'https://10.0.0.33/v1';
  // static String projectEndPoint = 'https://10.5.54.255/v1';
  // static String projectEndPoint = 'https://10.5.129.135/v1';
  static String projectName = '67a351b601aca4ed39db';

  static final Client client = Client()
      .setEndpoint(projectEndPoint)
      .setProject(projectName)
      .setSelfSigned();

  static final Account account = Account(client);
  static final Teams teams = Teams(client);
  static final Functions functions = Functions(client);
  static final Databases databases = Databases(client);
  static final Storage storage = Storage(client);
}

class DatabaseIds {
  static const String crcDatabase = '67a5a03a000bf36ee5a9';
  static const String formsDatabase = '67d9185800377484f0f4';
}

class TeamIds {
  static const String adminTeamId = '67a3a529002dc3bb99a5';
  static const String coordinatorTeamId = '67a356480037d1ad2c27';
  static const String studentTeamId = '67a356370034c7d30d4e';
}

class CollectionsIds {
  static const String batchConfigsCollection = '67a6ffd3001301054ce0';
  static const String usersCollection = '67a6fef2003d7ef6d69f';
  static const String companiesCollection = '67a5a04200109abb5416';
  static const String formsCollection = '67e14c440023de079420';
  static const String updatesCollection = '67e7bb6200014fc54cff';
}

class FunctionIds {
  static const String addUserToTeam = '67a352b30004ab7b74ed';
  static const String createForm = '67a8b2be002191ea0564';
}

class Buckets {
  static const String defaultResumeBucket = '67a86ff6000fcf767ea0';
  static const String jdFilesBucket = '67e1b0770005c7c11aaf';
  static const String responseFilesBucket = '67e520880016c9e81087';
}
