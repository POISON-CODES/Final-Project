part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAccountCreated extends AuthState {}

class AuthAdminAuthenticated extends AuthState {
  final UserModel user;
  AuthAdminAuthenticated(this.user);
}

class AuthStudentAuthenticated extends AuthState {
  final UserModel user;
  AuthStudentAuthenticated(this.user);
}

class AuthCoordinatorAuthenticated extends AuthState {
  final UserModel user;
  AuthCoordinatorAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class UsersListLoaded extends AuthState {
  final List<UserModel> users;
  UsersListLoaded(this.users);
}
