import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/features/auth/repositories/auth_remote_repository.dart';
import 'package:mainapp/models/models.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final authRemoteRepository = AuthRemoteRepository();

  void getInitialUser() async {
    emit(AuthLoading());
    final user = await authRemoteRepository.getCurrentUser();

    if (user == null) {
      emit(AuthInitial());
      return;
    }
    emit(AuthLogin(user));
  }

  void logInUser({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      final UserModel user = await authRemoteRepository.logInUser(
        email: email,
        password: password,
      );

      emit(AuthLogin(user));
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
