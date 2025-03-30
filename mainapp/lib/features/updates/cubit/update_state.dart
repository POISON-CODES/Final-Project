part of 'update_cubit.dart';

sealed class UpdateState {}

class UpdateInitial extends UpdateState {}

class UpdateLoading extends UpdateState {}

class UpdateCreated extends UpdateState {
  final UpdateModel model;

  UpdateCreated({required this.model});
}

class UpdatesLoaded extends UpdateState {
  final List<UpdateModel> updates;

  UpdatesLoaded({required this.updates});
}

class UpdateError extends UpdateState {
  final String error;

  UpdateError(this.error);
}
