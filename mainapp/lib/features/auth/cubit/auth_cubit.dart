import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mainapp/features/auth/repositories/auth_remote_repository.dart';
import 'package:mainapp/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final authRemoteRepository = AuthRemoteRepository();

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
