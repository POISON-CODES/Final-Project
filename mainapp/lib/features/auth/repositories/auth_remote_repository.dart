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

      final userModel = UserModel.fromMap({
        ...user.toMap(),
        ...userDoc.data,
      });

      return userModel;
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
          'role': Role.student.name,
          'masterDataFilled': false,
          'defaultFormFilled': false,
          'companies': [],
        },
      );

      return UserModel.fromMap({
        ...user.toMap(),
        'phoneNumber': phoneNumber,
        'role': Role.student.name,
        'masterDataFilled': false,
        'defaultFormFilled': false,
        'companies': [],
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
          'name': doc.data['name'],
          'email': doc.data['email'],
          'phoneNumber': doc.data['phoneNumber'],
          'role': doc.data['role'],
          '\$createdAt': doc.$createdAt,
          '\$updatedAt': doc.$updatedAt,
          'companies': doc.data['companies'] ?? [],
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

  Future<void> updateUserFormStatus({
    required String userId,
    bool? masterDataFilled,
  }) async {
    try {
      final Map<String, dynamic> data = {};
      if (masterDataFilled != null) {
        data['masterDataFilled'] = masterDataFilled;
      }

      await Appwrite.databases.updateDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.usersCollection,
        documentId: userId,
        data: data,
      );
    } catch (e) {
      throw Exception('Failed to update user form status: $e');
    }
  }

  Future<void> updateUserCompanies({
    required String userId,
    required List<String> companies,
  }) async {
    try {
      await Appwrite.databases.updateDocument(
        databaseId: DatabaseIds.crcDatabase,
        collectionId: CollectionsIds.usersCollection,
        documentId: userId,
        data: {
          'companies': companies,
        },
      );
    } catch (e) {
      throw Exception('Failed to update user companies: $e');
    }
  }
}
