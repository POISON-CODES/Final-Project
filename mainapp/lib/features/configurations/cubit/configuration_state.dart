part of 'configuration_cubit.dart';

sealed class ConfigurationState {}

class ConfigurationInitial extends ConfigurationState {}

class ConfigurationLoading extends ConfigurationState {}

class ConfigurationCreated extends ConfigurationState {
  final ConfigurationModel model;

  ConfigurationCreated({required this.model});
}

class ConfigurationEdit extends ConfigurationState {
  final ConfigurationModel model;

  ConfigurationEdit({required this.model});
}

class ConfigurationsLoaded extends ConfigurationState {
  final List<ConfigurationModel> configurations;

  ConfigurationsLoaded({required this.configurations});
}

class ConfigurationError extends ConfigurationState {
  final String error;

  ConfigurationError(this.error);
}
