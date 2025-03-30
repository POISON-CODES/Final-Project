import 'package:appwrite/appwrite.dart' show AppwriteException, ID, Query;
import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/models/models.dart';

class AuthRemoteRepository {
  Future<UserModel?> getCurrentUser() async {
    try {
      final user = await Appwrite.account.get();
      final userDoc = await Appwrite.databases.getDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.usersCollection,
        documentId: user.$id,
      );

      return UserModel.fromMap({
        ...user.toMap(),
        ...userDoc.data,
      });
    } catch (e) {
      return null;
    }
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
      final userDoc = await Appwrite.databases.getDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.usersCollection,
        documentId: user.$id,
      );

      return UserModel.fromMap({
        ...user.toMap(),
        ...userDoc.data,
      });
    } on AppwriteException catch (e) {
      throw Exception('Login failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<UserModel> createUser({
    required String email,
    required String password,
    required String name,
    required String phoneNumber,
    Role role = Role.student,
  }) async {
    try {
      final user = await Appwrite.account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );

      await Appwrite.databases.createDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.usersCollection,
        documentId: user.$id,
        data: {
          'name': name,
          'email': email,
          'phoneNumber': phoneNumber,
          'role': role.toString().split('.').last,
        },
      );

      return UserModel.fromMap({
        ...user.toMap(),
        'phoneNumber': phoneNumber,
        'role': role.toString().split('.').last,
      });
    } on AppwriteException catch (e) {
      throw Exception('Signup failed: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<void> updateUserRole(String userId, Role newRole) async {
    try {
      await Appwrite.databases.updateDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.usersCollection,
        documentId: userId,
        data: {
          'role': newRole.toString().split('.').last,
        },
      );
    } catch (e) {
      throw Exception('Failed to update user role: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await Appwrite.account.deleteSession(sessionId: 'current');
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  Future<List<UserModel>> getUsersByRole(Role role) async {
    try {
      final docs = await Appwrite.databases.listDocuments(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.usersCollection,
        queries: [
          Query.equal('role', Role.admin.name),
        ],
      );
      return docs.documents.map((doc) {
        return UserModel.fromMap({
          '\$id': doc.$id,
          'name': "Aman Keswani",
          'email': "aman@gmail.com",
          'phoneNumber': "+919826000000",
          'role': Role.admin.name,
          '\$createdAt': doc.$createdAt,
          '\$updatedAt': doc.$updatedAt,
        });
      }).toList();
    } catch (e) {
      throw Exception('Failed to get users by role: $e');
    }
  }

  Future<List<UserModel>> getAllAdmins() async {
    return getUsersByRole(Role.admin);
  }

  Future<List<UserModel>> getAllStudents() async {
    return getUsersByRole(Role.student);
  }

  Future<List<UserModel>> getAllCoordinators() async {
    return getUsersByRole(Role.coordinator);
  }
}
