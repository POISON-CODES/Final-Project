import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/constants/appwrite.dart';
import 'package:mainapp/core/utils/types.dart';
import 'package:mainapp/features/auth/repositories/auth_remote_repository.dart';
import 'package:mainapp/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final authRemoteRepository = AuthRemoteRepository();

  void logInUser({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      final Result result = await authRemoteRepository.logInUser(
        email: email,
        password: password,
      );

      final user = result.userModel;
      final userTeamId = result.teamId;

      if (userTeamId == Appwrite.adminTeamId) {
        emit(AuthAdmin(user));
      } else if (userTeamId == Appwrite.coordinatorTeamId) {
        emit(AuthMid(user));
      } else {
        emit(AuthStudent(user));
      }

      if (user == null) {
        emit(AuthError("User not found"));
        return;
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void createUser({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
  }) async {
    try {
      emit(AuthLoading());
      await authRemoteRepository.createUser(
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
      );

      emit(AuthSignUp());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
