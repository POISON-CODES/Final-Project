part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSignUp extends AuthState {}

final class AuthLogin extends AuthState {
  final UserModel user;
  AuthLogin(this.user);
}

final class AuthAdmin extends AuthLogin {
  AuthAdmin(super.user);
}

final class AuthMid extends AuthLogin {
  AuthMid(super.user);
}

final class AuthStudent extends AuthLogin {
  AuthStudent(super.user);
}

final class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
}
