part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSignUp extends AuthState {}

final class AuthAdmin extends AuthState {
  final UserModel user;
  AuthAdmin(this.user);
}

final class AuthMid extends AuthState {
  final UserModel user;
  AuthMid(this.user);
}

final class AuthStudent extends AuthState {
  final UserModel user;
  AuthStudent(this.user);
}

final class AuthError extends AuthState {
  final String error;
  AuthError(this.error);
}
