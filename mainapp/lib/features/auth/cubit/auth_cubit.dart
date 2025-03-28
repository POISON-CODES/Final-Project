import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/constants/constants.dart';
import 'package:mainapp/features/auth/repositories/auth_remote_repository.dart';
import 'package:mainapp/models/models.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRemoteRepository _authRepository = AuthRemoteRepository();

  AuthCubit() : super(AuthInitial());

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.logInUser(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Successfully logged in"),
        ),
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    Role role = Role.student,
    required BuildContext context,
  }) async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.createUser(
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        role: role,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Account Created! "),
        ),
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      emit(AuthLoading());
      await _authRepository.signOut();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> checkAuthStatus() async {
    try {
      emit(AuthLoading());
      final user = await _authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> getAllAdmins() async {
    try {
      emit(AuthLoading());
      final users = await _authRepository.getAllAdmins();
      emit(UsersListLoaded(users));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> getAllStudents() async {
    try {
      emit(AuthLoading());
      final users = await _authRepository.getAllStudents();
      emit(UsersListLoaded(users));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> getAllCoordinators() async {
    try {
      emit(AuthLoading());
      final users = await _authRepository.getAllCoordinators();
      emit(UsersListLoaded(users));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
