part of 'application_cubit.dart';

sealed class ApplicationState {}

class ApplicationInitial extends ApplicationState {}

class ApplicationLoading extends ApplicationState {}

class ApplicationLoaded extends ApplicationState {
  final List<ApplicationModel> applications;

  ApplicationLoaded(this.applications);
}

class ApplicationError extends ApplicationState {
  final String error;

  ApplicationError(this.error);
}
